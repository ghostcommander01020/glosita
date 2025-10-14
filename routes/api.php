<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\TagController;
use App\Http\Controllers\MarkerController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\AlertController;
use App\Http\Controllers\FilterController;
use App\Http\Controllers\ProxyController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::prefix('auth')->group(function () {
    // Public routes
    Route::post('login', [AuthController::class, 'login'])->name('login');
    Route::post('register', [AuthController::class, 'register']);
    Route::post('new/password', [AuthController::class, 'resetPassword']);
    Route::get('categories', [CategoryController::class, 'getCategories']);
    Route::get('tags', [TagController::class, 'getTags']);

    // Protected routes (auth:api)
    Route::middleware('auth:api')->group(function () {
        Route::get('logout', [AuthController::class, 'logout']);
        Route::get('user', [AuthController::class, 'user']);
        Route::get('user/{user_id}', [AuthController::class, 'chatuser']);

        Route::get('markers', [MarkerController::class, 'getMarkers'])->name('get-markers');
        Route::post('create/marker', [MarkerController::class, 'create'])->name('new-marker');
        Route::put('update/marker/{marker}', [MarkerController::class, 'update'])->name('update-marker');
        Route::delete('delete/marker/{marker}', [MarkerController::class, 'delete'])->name('delete-marker');

        Route::put('update-user', [UserController::class, 'update'])->name('update-user');
        Route::get('users-position', [UserController::class, 'getUsersPosition']);
        Route::put('user-status', [UserController::class, 'setUserStatus']);
        Route::put('update-user-position', [UserController::class, 'updateUserPosition']);
        Route::get('buddies', [UserController::class, 'getBuddies']);

        Route::get('get/alert', [AlertController::class, 'getAlert']);
        Route::get('get/alerts', [AlertController::class, 'getAllAlerts']);
        Route::post('create/alert', [AlertController::class, 'create']);
        Route::delete('delete/alert', [AlertController::class, 'delete']);

        Route::get('get/filters/{category_id}', [FilterController::class, 'getFilter']);

        Route::post('user/avatar', [UserController::class, 'updateUserAvatar'])->name('update-user-avatar');
        Route::put('update/im/here', [UserController::class, 'updateImHere'])->name('im-here');
    });

    // Proxy route (public)
    Route::get('/proxy/google-maps', [ProxyController::class, 'proxyToGoogleMaps']);
});