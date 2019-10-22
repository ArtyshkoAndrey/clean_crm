<?php
namespace App\Http\Controllers\Tasks;

use Illuminate\Http\Request;
use Illuminate\View\View;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\Model\Task;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;

class TaskController extends Controller {
    public function all (Request $request) {
        $tasks = Task::where('user_id', 1)->get();
    if (isset($request->sortName)) {
      $tasks = Task::where('user_id', 1)
        ->when($request, function ($query, $request) {
          return $query->orderBy($request->sortName, $request->sortType);
      })
      ->paginate(10);
    } else {
      $tasks = Task::where('user_id', 1)->paginate(10);
    }
  return response()->json($tasks, 200);
    }
}