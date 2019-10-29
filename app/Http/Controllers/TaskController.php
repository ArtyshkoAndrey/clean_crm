<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\View\View;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\Model\Task;
use App\Model\Responsible;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use App\Model\Image;
use Carbon\Carbon;

class TaskController extends Controller {
  public function all (Request $request) {
    $tasks = Task::where('user_id', auth()->user()->id)->get();
    if (isset($request->filter) && $request->filter !== '') {
      $filter = $request->filter;
      $tasks = Task::where('user_id', auth()->user()->id)->get();
      $tasks = $tasks->filter(function($task) use ($filter) {
        return strstr(mb_strtolower($task->street), mb_strtolower($filter)) ||
               strstr(mb_strtolower($task->number_home), mb_strtolower($filter)) ||
               strstr(mb_strtolower($task->description), mb_strtolower($filter)) ||
               strstr($task->target_date->toDateString(), mb_strtolower($filter)) ||
               strstr($task->date_of_detection->toDateString(), mb_strtolower($filter));
    });
    $tasks = $tasks->paginate(10);
    } else if (isset($request->sortName)) {
      $tasks = Task::where('user_id', auth()->user()->id)
        ->when($request, function ($query, $request) {
          return $query->orderBy($request->sortName, $request->sortType);
      })
      ->paginate(10);
    } else {
      $tasks = Task::where('user_id', 1)->paginate(10);
    }
    return response()->json($tasks, 200);
  }

  public function view ($id) {
    $task = Task::where('id', $id)->first();
    if (auth()->user()->id ===  $task->user_id) {
      return response()->json($task, 200);
    }
    return response()->json('Задача другого пользователя', 400);
  }

  public function drop($id) {
    Task::where('id', $id)->first()->delete();
    return response()->json('Success', 200);
  }

  public function taskfile (Request $request) {
    if($request->file('file'))
    {
      $image = $request->file('file');
      $name = time().$image->getClientOriginalName();
      $image->move(public_path().'/images/tasks/', $name);
      // dd(filesize(public_path().'/images/tasks/'.$name));

      $img = Image::create([
        'path' => json_encode(array(
            'file' => '/images/tasks/'.$name,
            'type' => 'type/'.$image->getClientOriginalExtension(),
            'size' => filesize(public_path().'/images/tasks/'.$name),
            'name' => $name
          )
        )
      ]);
      return response()->json([
        'success' => 'You have successfully uploaded an image',
        'image' => $img
      ], 200);
    }
    return response()->json([
      'error' => 'no file'
    ], 200);
  }

  public function update (Request $request) {
    $task = Task::find($request->id);
    $task['name'] = $request->name;
    $request->conductedWork != "" ? $task['conducted_work'] = $request->conductedWork : null;
    $request->correctionDate != "" ? $task['correction_date'] = new Carbon($request->_correctionDate) : null;
    $request->responsibleExecutor != "" ? $task['responsible_executor'] = $request->responsibleExecutor : null;
    $task['street'] = $request->street['value'];
    $task['number_home'] = $request->numberHome;
    $task['description'] = $request->description;
    $task['date_of_detection'] = new Carbon($request->_dateOfDetection);
    $responsible = Responsible::find($request->responsible['id']);
    $task->responsible()->associate($responsible);
    $identified = [];
    foreach ($request->identified as $value) {
      array_push($identified, (int) $value['id']);
    }
    $images = [];
    foreach ($request->images as $value) {
      array_push($images, (int) $value['id']);
    }
    $task->identified()->sync($identified);
    $task->images()->sync($images);
    $task['target_date'] = new Carbon($request->_targetDate);
    $task->save();
    return response()->json('Success', 200);
  }
}