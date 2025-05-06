<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/register/verify/{code}', 'UserController@verify')->name('email_verify');

Route::get('/reset/password/{code}', 'UserController@new_password_view');
Route::put('/change/password', 'UserController@change_password')->name('change_password');

Route::get('/', 'LandingController@index');
