<?php

use Illuminate\Http\Request;
use App\Http\Requests;
use App\Model\Task;

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

Route::get('/test', function(Request $request) {
    $tasks = Task::where('user_id', 1)->get();
    if (isset($request->filter) && $request->filter !== '') {
      echo 'TEST \n';
      $tasks = Task::where('user_id', 1)->where('street', 'LIKE', "%{$request->filter}%")->orWhere('number_home', 'LIKE', "%{$request->filter}%")->orWhere('description', 'LIKE', "%{$request->filter}%")->orWhere('target_date', 'LIKE', "%{$request->filter}%")->orWhere('detection_date', 'LIKE', "%{$request->filter}%")->paginate(10);
    } else if (isset($request->sortName)) {
      $tasks = Task::where('user_id', 1)
        ->when($request, function ($query, $request) {
          return $query->orderBy($request->sortName, $request->sortType);
      })
      ->paginate(10);
    } else {
      $tasks = Task::where('user_id', 1)->paginate(10);
    }
  return response()->json($tasks, 200);
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
Route::post('/taskfile','TaskController@taskfile');

// admin route
Route::group(['prefix' => 'admin', 'middleware' => 'api.auth'], function (){
  Route::post('/profile', [
    'as' => 'admin.profile', 'uses' => 'UserController@profile'
  ]);
  Route::post('/users', [
    'as' => 'admin.users', 'uses' => 'UserController@allUsers'
  ]);
  Route::post('/responsibles', [
    'as' => 'admin.responsibles', 'uses' => 'UserController@allresponsible'
  ]);
  Route::post('/responsibles/create', [
    'as' => 'admin.responsibles.create', 'uses' => 'UserController@responsibleCreate'
  ]);
  Route::group(['prefix' => 'task'], function () {
    Route::get('/get', [
      'as' => 'admin.task.all', 'uses' => 'TaskController@all'
    ]);
    Route::post('/view/{id}', [
      'as' => 'admin.task.view', 'uses' => 'TaskController@view'
    ]);
    Route::put('/', [
      'as' => 'admin.task.update', 'uses' => 'TaskController@update'
    ]);
    Route::delete('/{id}', [
      'as' => 'admin.task.drop', 'uses' => 'TaskController@drop'
    ]);
  });
    // Route::resource('todos', 'Demo\TodosController');
    // Route::post('todos/toggleTodo/{id}', [
    //     'as' => 'admin.todos.toggle', 'uses' => 'Demo\TodosController@toggleTodo'
    // ]);
    // Route::group(['prefix' => 'settings'], function () {
    //     Route::post('/social', [
    //         'as' => 'admin.settings.social', 'uses' => 'Demo\SettingsController@postSocial'
    //     ]);
    // });
    // Route::group(['prefix' => 'users'], function () {
    //     Route::get('/get',[
    //         'as' => 'admin.users', 'uses' => 'Demo\PagesController@allUsers'
    //     ]);
    //     Route::delete('/{id}',[
    //         'as' => 'admin.users.delete', 'uses' => 'Demo\PagesController@destroy'
    //     ]);
    // });
});

