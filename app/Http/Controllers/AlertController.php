<?php

namespace App\Http\Controllers;

use App\Alert;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AlertController extends Controller
{
    public function getAlert(Request $request)
    {
        $user = Auth::user();
        $alert = Alert::where('user_id', $user->id)->first();

        return response()->json([
           'alert' => $alert
        ], 200);
    }

    public function getAllAlerts(Request $request)
    {
        $alerts = Alert::where('active', true)->with('user')->get();

        return response()->json([
            'alerts' => $alerts
        ], 200);

    }

    public function create(Request $request)
    {
        $user = Auth::user();

        $alert = new Alert;
        if (isset($request->description)) $alert->description = $request->description;
        $alert->user_id = $user->id;
        $alert->position_lat = $user->position_lat;
        $alert->position_lng = $user->position_lng;

        $alert->save();

        return response()->json([
            'message' => 'Successfully created alert!'
        ], 201);
    }


    public function delete(Request $request)
    {
        try {
            $user = Auth::user();
            $alert = Alert::where('user_id', $user->id)->first();
            $alert->active = false;
            $alert->save();
            $alert->delete();

            return response()->json([
                'message' => 'Successfully deleted alert!'
            ], 201);
        } catch (\Exception $e)
        {
            return response()->json([
                'message' => 'There is error!'
            ], 422);
        }
    }
}
