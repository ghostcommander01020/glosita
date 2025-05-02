<?php

namespace App\Http\Controllers;

use App\Alert;
use App\Category;
use App\Tag;
use App\User;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Intervention\Image\ImageManagerStatic as Image;


class UserController extends Controller
{
    public function update(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
            'alias' => 'required|string',
            'surname' => 'required|string',
            'birthdate' => 'required|date',
            'sex' => 'required|string',
            'email' => 'required|string|email',
            'category' => 'required',
            //'password' => 'required|string'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Por favor, asegúrese de rellenar los campos obligatorios',
                'title' => 'Datos sin rellenar'
            ], 409);
        }

        try {
            $user = $request->user();

            $category = Category::where('name', $request->category['name'])->first();

            if ($user->email != $request->email)
            {
                if (User::where('email',$request->email)->exists()) return 'Email must be unique';
            }

            if ($user->alias != $request->alias)
            {
                if (User::where('alias',$request->alias)->exists()) return 'Alias must be unique';
            }

            $user->fill(Input::except('password', 'photo', 'category'));

            if (isset($request->password)) $user->password = bcrypt($request->password);

            $user->category_id = $category->id;

            $user->save();

            $user->category = $category;

        } catch (\Exception $e)
        {
            Log::warning($e);
        }

        return response()->json([
            'message' => 'Usuario guardado con éxito',
            'user' => $user
        ], 200);

    }

    function updateImHere(Request $request)
    {
        $user_logged = Auth::user();
        $user_logged->im_here = date("Y-m-d H:i:s");
        $user_logged->save();
    }

    function distanceCalculation($point1_lat, $point1_long, $point2_lat, $point2_long, $unit = 'km', $decimals = 2)
    {
        $degrees = rad2deg(acos((sin(deg2rad($point1_lat))*sin(deg2rad($point2_lat))) + (cos(deg2rad($point1_lat))*cos(deg2rad($point2_lat))*cos(deg2rad($point1_long-$point2_long)))));

        $distance = $degrees * 111.13384;

        return round($distance, $decimals);
    }

    public function getUsersPosition(Request $request)
    {
        $users = User::select('id', 'alias', 'name', 'surname', 'birthdate','sex','photo','position_lat','position_lng', 'category_id', 'active', 'visibility', 'distance_filter', 'description', 'blocked_users')->with('marker')->get();
        $users_formatted = [];

        $user_logged = Auth::user();


        foreach ($users as $user)
        {
            $alert = Alert::where('user_id', $user->id)->first();

            if ($user->id != $user_logged->id)
            {
                $users_distance = $this->distanceCalculation($user_logged->position_lat, $user_logged->position_lng, $user->position_lat, $user->position_lng);
                if ($users_distance > $user_logged->distance_filter)
                {
                    continue;
                }
            }

            if ($alert) $user->alert = $alert;
            else $user->alert = null;

            $category_selected = Category::where('id', $user->category_id)->first();

            $actually_date = new DateTime();
            $birthdate = new DateTime($user->birthdate);
            $diff = $actually_date->diff($birthdate);
            $user->age = floor($diff->days / 365);

            $user->category = $category_selected->name;

            $users_formatted[] = $user;

        }

        return response()->json($users_formatted);

    }

    public function updateUserPosition(Request $request)
    {
        $request->validate([
            'lat' => 'required',
            'lng' => 'required',
        ]);

        $user = $request->user();

        $user->active = true;

        $user->position_lat = $request->lat;
        $user->position_lng = $request->lng;

        $user->im_here = date("Y-m-d H:i:s");

        $user->save();

        Log::info('Posición de '.$user->name.'actualizada');

        return response()->json($user);
}

    public function setUserStatus(Request $request)
    {
        $user = $request->user();

        if (!$user) return 'Need login';

        $user->active = $request->active;

        $user->save();

        return 'done';
    }

    public function verify($code)
    {
        $user = User::where('confirmation_code', $code)->where('confirmed', false)->first();

        Log::warning('*************** Usuario verificado ***************');
        Log::info($user);

        try {
            $user->confirmed = true;
            $user->save();
        } catch (\Exception $e)
        {
            Log::warning('Fallo al verificar usuario');
        }

        return view('emails.register_completed');
    }

    public function new_password_view($code)
    {
        $user = User::where('confirmation_code', $code)->first();

        Log::info('**********');
        Log::warning($user);

        return view('emails.change_password', compact('user'));
    }

    public function change_password(Request $request)
    {
        $user = User::findOrfail($request->user_id);
        $user->password = bcrypt($request->password1);

        $user->save();

        return view('emails.password_changed');

    }

    public function getBuddies(Request $request)
    {
        $buddies = explode(',', $request->buddies);

        $users = [];

        foreach ($buddies as $buddy) {
            $user = User::select('id', 'alias', 'name', 'surname', 'birthdate','sex','photo','position_lat','position_lng', 'active', 'category_id', 'visibility', 'description', 'blocked_users')->where('id', $buddy)->first();

            $category_selected = Category::where('id', $user->category_id)->first();

            $user->category = $category_selected->name;

            array_push($users, $user);
        }

        return response()->json($users);
    }

    public function updateUserAvatar(Request $request)
    {
        try {
            $user = $request->user();

            $new_file_name = $user->id.'_'.$user->avatar_changes;

            $old_changes = $user->avatar_changes - 1;
            $old_file_name = $user->id.'_'.$old_changes;

            $path = public_path().'/avatars/' . $new_file_name.'.jpeg';

            $fileName = $user->id;

            if(file_exists(public_path('avatars/'.$old_file_name.'.jpeg')))
            {
                unlink(public_path('avatars/'.$old_file_name.'.jpeg'));
            } else {
                Log::info('El archivo no existe');
            }

            Image::make(file_get_contents($request->photo))->save($path);

            $user->photo = $new_file_name.'.jpeg';
            $user->avatar_changes += 1;

            $user->save();


            return response()->json([
                'message' => 'Usuario guardado con éxito',
            ], 200);

//            if (preg_match('/^data:image\/(\w+);base64,/', $request->photo)) {
//                $data = substr($request->photo, strpos($request->photo, ',') + 1);
//
//                $data = base64_decode($data);
//                $data->move('avatars/', $user->id.'.jpeg');
//
//                return response()->json([
//                    'message' => 'Usuario guardado con éxito',
//                ], 200);
//            }

//            if ($request->file('photo')->isValid()) {
//
//                $fileName = $user->id;
//
//                $fileExtension = $request->photo->getClientOriginalExtension();
//
//                $fileAllName = $fileName.'.'.$fileExtension;
//

//
//                $user->photo = $fileAllName;
//
//                $user->save();

//                $request->photo->move('avatars/', $fileAllName);
//

//            }
        } catch (\Exception $e) {
            Log::info($e);
            return response()->json($e);
        }
    }
}
