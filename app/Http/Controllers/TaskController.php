<?php

namespace App\Http\Controllers;

use App\Model\Image;
use App\Model\Responsible;
use App\Model\Task;
use App\Model\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use File;

class TaskController extends Controller
{
  public function addfile (Request $request) {
    if($request->file('file')) {
      $image = $request->file('file');
      $name = $image->getClientOriginalName();
      $image->move(public_path().'/images/tasks/', $name);

      $img = Image::create([
        'task_id' => null,
        'path' => [
          'file' => '/images/tasks/'.$name,
          'type' => 'type/'.$image->getClientOriginalExtension(),
          'size' => filesize(public_path().'/images/tasks/'.$name),
          'name' => $name,
        ]
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

  public function dropfile ($name) {
    if ($name) {
      $image = Image::where('path->name', $name)->first();
      if ($image) {
        $image->tasks()->detach();
        $image->delete();
        File::delete(public_path().'/images/tasks/'.$name);
        return response()->json([
          'success' => 'Изображение удалено',
          'image' => $name
        ], 200);
      }
      return response()->json([
        'success' => 'Изображение не найдено',
        'image' => $name
      ], 200);
    }
    return response()->json([
      'error' => 'no file'
    ], 200);
  }

  /**
   * Display a listing of the resource.
   *
   * @return void
   */
  public function index() {
    $tasks = Task::with('identified', 'responsible')->whereHas('identified', function($q){
      $q->where('user_id', auth()->user()->id);
    })->get();
    $users = User::all();
    $responsibles = Responsible::all();
    return response()->json([
      'status' => 'Success',
      'tasks' => $tasks,
      'users' => $users,
      'responsibles' => $responsibles
    ]);
  }

  /**
   * Display a listing of the resource.
   *
   * @param Request $request
   * @return void
   */
    public function filter(Request $request)
    {
      $tasks = Task::with('identified', 'responsible')->whereHas('identified', function($q){
        $q->where('user_id', auth()->user()->id);
      })->get();
      foreach($request->filter as $filter) {
        switch($filter['type']) {
          case 'text': {
            $tasks = $tasks->where($filter['field'], $filter['value']);
            break;
          }
//          TODO Доделать под даты
          case 'date': {
            $tasks = $tasks->where($filter['field'], $filter['value']);
            break;
          }
          case 'select': {
            switch($filter['field']) {
              case 'identified': {
                $tasks = $tasks->filter(function($item) use (&$filter) {
                  return $item->identified->contains('id', $filter['value']);
                });
                break;
              }
              case 'responsible': {
                $tasks = $tasks->filter(function($item) use (&$filter) {
                  return $item->responsible->id == $filter['value'];
                });
                break;
              }
              case 'status': {
                switch($filter['value']) {
                  case 'work': {
                    $tasks = $tasks->where('target_date', '>=', Carbon::now()->toDateString())
                      ->where('correction_date', null);
                    break;
                  }
                  case 'complete': {
                    $tasks = $tasks->where('correction_date', '!=', null)->where('correction_date', '<=', Carbon::now()->toDateTimeString());
                    break;
                  }
                  case 'overdue': {
                    $tasks = $tasks->where('target_date', '<', Carbon::now()->toDateTimeString())
                      ->where('correction_date', null);
                    break;
                  }
                }
                break;
              }
            }
            break;
          }
        }
      }
      return response()->json($tasks, 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
      $task = Task::with('identified', 'images', 'responsible')->where('id', $id)->first();
      for($i = 0; $i < count($task->identified); $i++) {
        if (auth()->user()->id == $task->identified[$i]->id) {
          return response()->json([
            'status' => 'Success',
            'task' => $task,
            'users' => User::all(),
            'responsibles' => Responsible::all()
          ]);
        }
      }
      return response()->json('Задача другого пользователя', 400);
    }

  /**
   * Update the specified resource in storage.
   *
   * @param \Illuminate\Http\Request $request
   * @param int $id
   * @return \Illuminate\Http\Response
   * @throws \Exception
   */
    public function update(Request $request, $id)
    {
      $task = Task::find($id);
      $task['name'] = $request->name;
      $request->conductedWork != "" ? $task['conducted_work'] = $request->conductedWork : null;
      $request->_correctionDateString != "" ? $task['correction_date'] = new Carbon($request->_correctionDateString) : null;
      $request->responsibleExecutor != "" ? $task['responsible_executor'] = $request->responsibleExecutor : null;
      $task['street'] = $request->street['value'];
      $task['number_home'] = $request->numberHome;
      $task['description'] = $request->description;
      $task['detection_date'] = new Carbon($request->_detectionDateString);
      $responsible = Responsible::find($request->responsible['id']);
      $task->responsible()->associate($responsible);
      $identified = [];
      foreach ($request->identified as $value) {
        array_push($identified, (int) $value['id']);
      }
      foreach ($request->images as $value) {
        $task->images()->save(Image::find($value['id']));
      }
      $task->identified()->sync($identified);
      $task['target_date'] = new Carbon($request->_targetDateString);
      $task->save();
      return response()->json('Success', 200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
      Task::where('id', $id)->first()->delete();
      return response()->json(['status' => 'Success']);
    }
}
