<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Model\User;

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
    try {
      $user = User::where('id', $id)->first();
      return response()->json([
        'status' => 'success',
        'user' => $user
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
    //
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
