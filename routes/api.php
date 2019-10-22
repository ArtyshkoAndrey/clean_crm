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
});


Route::group(['prefix' => 'auth'], function () {
    Route::post('login','AuthController@authenticate');
    Route::post('register','AuthController@authenticate');
    Route::get('logout','AuthController@logout');
    Route::get('check','AuthController@check');
});

// session route
Route::post('email-exist',[
    'as' => 'email-exist','uses' => 'Demo\PagesController@emailExist'
]);

// admin route
Route::group(['prefix' => 'admin', 'middleware' => 'api.auth'], function (){
  Route::group(['prefix' => 'tasks'], function () {
    Route::get('/get', [
      'as' => 'admin.tasks.all', 'uses' => 'Tasks\TaskController@all'
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

