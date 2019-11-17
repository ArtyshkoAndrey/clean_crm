<?php

use Illuminate\Http\Request;
use App\Http\Requests;
use App\Model\User;
use Carbon\Carbon;
use App\Model\Profile;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('/test', function (){
  $user = User::where('id', 1)->first();
  $user->roles()->sync([1]);
  
  return response()->json($user);
});

Route::group(['prefix' => 'auth'], function () {
    Route::post('login','AuthController@authenticate');
    Route::post('register','AuthController@registration');
    Route::get('logout','AuthController@logout');
    Route::get('check','AuthController@check');
});
Route::post('email-exist',[
  'as' => 'email-exist','uses' => 'AuthController@emailExist'
]);
Route::post('/taskfile','TaskController@taskfileCreate');
Route::delete('/taskfile/{name}','TaskController@taskfileDelete');

// admin route
Route::group(['prefix' => 'admin', 'middleware' => 'api.auth'], function (){
  Route::apiResource('user', 'UserController');
  Route::post('/profile', [
    'as' => 'admin.profile', 'uses' => 'HelperController@profile'
  ]);
  Route::post('/usershelp', [
    'as' => 'admin.users', 'uses' => 'HelperController@allUsers'
  ]);
  Route::post('/responsibles', [
    'as' => 'admin.responsibles', 'uses' => 'HelperController@allresponsible'
  ]);
  Route::post('/responsibles/create', [
    'as' => 'admin.responsibles.create', 'uses' => 'HelperController@responsibleCreate'
  ]);
  Route::group(['prefix' => 'task'], function () {
    Route::post('/get', [
      'as' => 'admin.task.all', 'uses' => 'TaskController@all'
    ]);
    Route::post('/view/{id}', [
      'as' => 'admin.task.view', 'uses' => 'TaskController@view'
    ]);
    Route::put('/', [
      'as' => 'admin.task.update', 'uses' => 'TaskController@update'
    ]);
    Route::post('/', [
      'as' => 'admin.task.create', 'uses' => 'TaskController@create'
    ]);
    Route::delete('/{id}', [
      'as' => 'admin.task.drop', 'uses' => 'TaskController@drop'
    ]);
  });
});

