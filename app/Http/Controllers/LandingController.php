<?php

namespace App\Http\Controllers;

use App\Category;
use App\Tag;
use App\User;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Log;

class LandingController extends Controller
{
    public function index()
    {
        return view('welcome');
    }
}
