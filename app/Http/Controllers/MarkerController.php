<?php

namespace App\Http\Controllers;

use App\Category;
use App\Marker;
use Illuminate\Http\Request;

use App\User;
use DateTime;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class MarkerController extends Controller
{
    public function getMarkers(Request $request)
    {
        $user = $request->user();
        $markers = Marker::where('user_id', $user->id)->with('user')->with('category')->get();

        return response()->json($markers);

    }

    public function create(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string',
            'info' => 'required|string',
            'address' => 'required|string',
            'position_lat' => 'required',
            'position_lng' => 'required',
            'user_id' => 'required',
            'category_id' => 'required',
        ]);

        if ($validator->fails()) {
            Log::info($validator->errors());
            return response()->json([
                'message' => 'Por favor, asegúrese de rellenar los campos obligatorios',
                'title' => 'Datos sin rellenar'
            ], 409);
        }


        $marker = new Marker;
        $marker->title = $request->title;
        $marker->info = $request->info;
        $marker->address = $request->address;
        $marker->position_lat = $request->position_lat;
        $marker->position_lng = $request->position_lng;
        $marker->user_id = $request->user_id;
        $marker->category_id = $request->category_id;

        if (isset($request->filters)) {
            $marker->filters = $request->filters;
        }

        $marker->save();

        $markers = Marker::where('user_id', $request->user_id)->with('user')->with('category')->get();

        return response()->json([
            'message' => 'Successfully created marker!',
            'markers' => $markers
        ], 201);
    }

    public function update(Request $request, $marker_id)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string',
            'info' => 'required|string',
            'address' => 'required|string',
            'position_lat' => 'required',
            'position_lng' => 'required',
            'user_id' => 'required',
            'category_id' => 'required',
        ]);

        if ($validator->fails()) {
            Log::info($validator->errors());
            return response()->json([
                'message' => 'Por favor, asegúrese de rellenar los campos obligatorios',
                'title' => 'Datos sin rellenar'
            ], 409);
        }

        if (!isset($request->filters)) {
            $request->filters = null;
        }

        $marker = Marker::where('id', $marker_id)->update([
            'title' => $request->title,
            'info' => $request->info,
            'address' => $request->address,
            'position_lat' => $request->position_lat,
            'position_lng' => $request->position_lng,
            'filters' => $request->filters
        ]);
        
        $markers = Marker::where('user_id', $request->user_id)->with('user')->with('category')->get();

        return response()->json([
            'message' => 'Successfully updated marker!',
            'markers' => $markers
        ], 201);

    }

    public function delete(Request $request, $marker_id)
    {
        $marker = Marker::find($marker_id);
        $marker->delete();

        $user = $request->user();
        $markers = Marker::where('user_id', $user->id)->with('user')->with('category')->get();

        return response()->json($markers);
    }
}
