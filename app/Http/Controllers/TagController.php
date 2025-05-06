<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Tag;

class TagController extends Controller
{
    public function getTags(Request $request)
    {
        $tags = Tag::find($request->id);

        return response()->json($tags);
    }
}
