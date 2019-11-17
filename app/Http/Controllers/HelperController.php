<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use App\Model\User;
use App\Model\Responsible;
use Carbon\Carbon;

class HelperController extends Controller
{
    public function profile()
    {
        if (auth()->user()) {
            return response()->json(auth()->user(), 200);
        }
        return response()->json('Error', 400);
    }

    public function allUsers()
    {
        if (auth()->user()) {
            return response()->json(User::all()->toArray(), 200);
        }
        return response()->json('Error', 400);
    }

    public function allresponsible () {
        if (auth()->user()) {
            return response()->json(Responsible::all()->toArray(), 200);
        }
        return response()->json('Error', 400);
    }
    public function responsibleCreate (Request $request) {
        Responsible::create([
            'id' => $request->id,
            'name' => $request->name
        ]);
        return response()->json(['status' => 'Success', 'message' => 'Добавлена новая запись']);
    }
    public function dashboard() {
        $tasks = auth()->user()->tasks;
        $work = $tasks->where('target_date', '>=', Carbon::now()->toDateString())->where('correction_date', null)->count();
        $overdue = $tasks->where('target_date', '<', Carbon::now()->toDateTimeString())->where('correction_date', null)->count();
        $complete = $tasks->where('correction_date', '!=', null)->where('correction_date', '<=', Carbon::now()->toDateTimeString())->count();
        $taskOverdue = $tasks->where('target_date', '<', Carbon::now()->toDateTimeString())->where('correction_date', null)->slice(0, 5);
        return response()->json([
            'overdue' => $overdue,
            'work' => $work,
            'complete' => $complete,
            'taskOverdue' => $taskOverdue,
            'status' => 'success'
        ]);
    }
}
