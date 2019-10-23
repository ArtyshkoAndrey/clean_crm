<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;

class UserController extends Controller
{
    public function profile()
    {
        if (auth()->user()) {
            return response()->json(auth()->user(), 200);
        }
        return response()->json('Error', 400);
    }
}
