<?php

use Illuminate\Http\Request;
use App\Http\Requests;

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

Route::group(['prefix' => 'auth'], function () {
    Route::post('login','AuthController@authenticate');
    Route::post('register','AuthController@registration');
    Route::get('logout','AuthController@logout');
    Route::get('check','AuthController@check');
});

Route::post('email-exist',[
  'as' => 'email-exist','uses' => 'AuthController@emailExist'
]);

Route::post('/taskfile','TasksController@taskfileCreate');
Route::delete('/taskfile/{name}','TasksController@taskfileDelete');

// admin route
Route::group(['prefix' => 'admin', 'middleware' => 'api.auth'], function (){

//  Пользователи
  Route::apiResource('user', 'UserController');

//  Проблемы
  Route::apiResource('task', 'TaskController'); // CRUD
  Route::post('task/filter', ['uses' => 'TaskController@filter', 'as' => 'task.filter']); // Фильтрация



  Route::post('/profile', [
    'as' => 'admin.profile', 'uses' => 'HelperController@profile'
  ]);
  Route::get('/dashboard', [
    'as' => 'admin.dashboard', 'uses' => 'HelperController@dashboard'
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

//  Route::group(['prefix' => 'task'], function () {
//    Route::post('/get', [
//      'as' => 'admin.task.all', 'uses' => 'TasksController@all'
//    ]);
//    Route::post('/view/{id}', [
//      'as' => 'admin.task.view', 'uses' => 'TasksController@view'
//    ]);
//    Route::put('/', [
//      'as' => 'admin.task.update', 'uses' => 'TasksController@update'
//    ]);
//    Route::post('/', [
//      'as' => 'admin.task.create', 'uses' => 'TasksController@create'
//    ]);
//    Route::delete('/{id}', [
//      'as' => 'admin.task.drop', 'uses' => 'TasksController@drop'
//    ]);
//  });
});

