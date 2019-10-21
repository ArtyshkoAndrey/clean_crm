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
        // return auth()->user()->id;
        $tasks = Task::where('user_id', auth()->user()->id)->paginate(5);
        return $tasks;
    }
}