<?php

namespace App\Http\Controllers;

use App\Model\Responsible;
use App\Model\Task;
use App\Model\User;
use Carbon\Carbon;
use Illuminate\Http\Request;

class TaskController extends Controller
{
  /**
   * Display a listing of the resource.
   *
   * @return void
   */
  public function index() {
    $tasks = auth()->user()->tasks;
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
      $tasks = auth()->user()->tasks;
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
      $task = Task::where('id', $id)->first();
      if (auth()->user()->id ===  $task->user_id) {
        return response()->json($task, 200);
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
      $images = [];
      foreach ($request->images as $value) {
        array_push($images, (int) $value['id']);
      }
      $task->identified()->sync($identified);
      $task->images()->sync($images);
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
