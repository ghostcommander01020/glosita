<?php

namespace App\Http\Controllers;

use App\Filter;
use Illuminate\Http\Request;

class FilterController extends Controller
{
    public function getFilter(Request $request, $category_id)
    {
        $filters = Filter::where('category_id', $category_id)->get();

        return response()->json($filters);
    }
}
