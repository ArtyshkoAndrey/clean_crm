<?php

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
Route::group(['prefix' => 'admin', 'middleware' => 'api.auth'], function () {

//  Пользователи
  Route::apiResource('user', 'UserController');

//  Проблемы
  Route::apiResource('task', 'TaskController'); // CRUD
  Route::post('task/filter', ['uses' => 'TaskController@filter', 'as' => 'task.filter']); // Фильтрация
  Route::post('task/file', ['uses' => 'TaskController@addfile', 'as' => 'task.addfile']); // Добавить картинку
  Route::delete('task/file/{name}', ['uses' => 'TaskController@dropfile', 'as' => 'task.dropfile']); // Удалить картинку



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
});

