<?php

use Illuminate\Http\Request;

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

//Route::middleware('auth:api')->get('/user', function (Request $request) {
//    return $request->user();
//});

Route::group([
    'prefix' => 'auth'
], function () {
    Route::post('login', 'Auth\AuthController@login')->name('login');
    Route::post('register', 'Auth\AuthController@register');
    Route::post('new/password', 'Auth\AuthController@resetPassword');
    Route::get('categories', 'CategoryController@getCategories');
    Route::get('tags', 'TagController@getTags');

    Route::group([
        'middleware' => 'auth:api'
    ], function() {
        Route::get('logout', 'Auth\AuthController@logout');
        Route::get('user', 'Auth\AuthController@user');
        Route::get('user/{user_id}', 'Auth\AuthController@chatuser');
        Route::get('markers', 'MarkerController@getMarkers')->name('get-markers');
        Route::post('create/marker', 'MarkerController@create')->name('new-marker');
        Route::put('update/marker/{marker}', 'MarkerController@update')->name('update-marker');
        Route::delete('delete/marker/{marker}', 'MarkerController@delete')->name('delete-marker');
        Route::put('update-user', 'UserController@update')->name('update-user');
        Route::get('users-position', 'UserController@getUsersPosition');
        Route::put('user-status', 'UserController@setUserStatus');
        Route::put('update-user-position', 'UserController@updateUserPosition');
        Route::get('buddies', 'UserController@getBuddies');

        Route::get('get/alert', 'AlertController@getAlert');
        Route::get('get/alerts', 'AlertController@getAllAlerts');
        Route::post('create/alert', 'AlertController@create');
        Route::delete('delete/alert', 'AlertController@delete');

        Route::get('get/filters/{category_id}', 'FilterController@getFilter');

        Route::post('user/avatar', 'UserController@updateUserAvatar')->name('update-user-avatar');

        Route::put('update/im/here', 'UserController@updateImHere')->name('im-here');

    });
    Route::get('/proxy/google-maps', 'ProxyController@proxyToGoogleMaps');

});
