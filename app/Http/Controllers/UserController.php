<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use App\Model\User;
use App\Model\Responsible;

class UserController extends Controller
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
}
