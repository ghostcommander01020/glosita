<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\LandingController;
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

Route::get('/', function () {
    return view('welcome');
});


Route::get('/register/verify/{code}', [UserController::class, 'verify'])->name('email_verify');

Route::get('/reset/password/{code}', [UserController::class, 'new_password_view']);
Route::put('/change/password', [UserController::class, 'change_password'])->name('change_password');

Route::get('/', [LandingController::class, 'index']);