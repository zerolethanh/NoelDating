<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::group(['prefix' => 'photo'], function () {
    Route::get('upload', 'PhotoController@uploadForm');
    Route::post('upload', 'PhotoController@upload');
});

Route::group(['prefix' => 'user'], function () {

    Route::get('email/{email}', 'UserController@email');
    Route::get('all', 'UserController@all');

    //register
    Route::get('reg-email-form','UserController@regEmailForm');
    Route::post('reg-email','UserController@regEmail');
});
