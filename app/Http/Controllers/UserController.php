<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Model\User;
use App\Model\Departments;
use Carbon\Carbon;

class UserController extends Controller
{
  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */
  public function index()
  {
    try {
      $users = User::all();
      return response()->json([
        'status' => 'success',
        'users' => $users
      ]);
    } catch (Illuminate\Database\QueryException $e) {
      return response()->json([
        'status' => 'error'
      ]);
    }
  }

  /**
   * Store a newly created resource in storage.
   *
   * @param  \Illuminate\Http\Request  $request
   * @return \Illuminate\Http\Response
   */
  public function store(Request $request)
  {
    return response()->json($request);
  }

  /**
   * Display the specified resource.
   *
   * @param  int  $id
   * @return \Illuminate\Http\Response
   */
  public function show($id)
  {
    try {
      $user = User::where('id', $id)->first();
      $roles = config('roles.models.role')::all();
      // TODO: Брать данные с бд
      $departments = Departments::all();
      return response()->json([
        'status' => 'success',
        'user' => $user,
        'roles' => $roles,
        'departments' => $departments
      ]);
    } catch (Illuminate\Database\QueryException $e) {
      return response()->json([
        'status' => 'error'
      ]);
    }
  }

  /**
   * Update the specified resource in storage.
   *
   * @param  \Illuminate\Http\Request  $request
   * @param  int  $id
   * @return \Illuminate\Http\Response
   */
  public function update(Request $request, $id)
  {
    // return response($request['name']);
    // return response()->json($request['profile']);
    $user = User::where('id', $id)->first();
    $user->name = $request['name'];
    $user->email = $request['email'];
    $profile = $user->profile ?: new Profile;
    $profile->birthday = new Carbon($request['profile']['birthday']);
    $profile->department_id = $request['profile']['department']['id'];
    $profile->user_id = $user->id;
    $user->profile->save([], $profile);
    $user->roles()->sync([$request['roles']['id']]);
    $user->save();
    return response()->json(['status' => 'success']);
  }

  /**
   * Remove the specified resource from storage.
   *
   * @param  int  $id
   * @return \Illuminate\Http\Response
   */
  public function destroy($id)
  {
    //
  }
}
