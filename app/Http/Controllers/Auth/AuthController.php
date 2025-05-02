<?php

namespace App\Http\Controllers\Auth;

use App\Category;
use App\Tag;
use App\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{

    /*
     * Login de usuarios
     */

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
            //'remember_me' => 'boolean'
        ]);

        $credentials = request(['email', 'password']);

        if(!Auth::attempt($credentials))
            return response()->json([
                'title' => 'Fallo en el login',
                'message' => 'Usuario y/o contraseña incorrectos'
            ], 401);

        $user = $request->user();
        if (!$user->confirmed)
        {
            Log::info('Email no verificado');
            return response()->json([
                'title' => 'Verificación necesaria',
                'message' => 'Por favor, verifique su correo'
            ], 401);
        }


        $tokenResult = $user->createToken('Personal Access Token');
        $token = $tokenResult->token;

        if ($request->remember_me)
            $token->expires_at = Carbon::now()->addWeeks(1);

        $token->save();

        $user->active = true;
        $user->save();

        return response()->json([
            'access_token' => $tokenResult->accessToken,
            'token_type' => 'Bearer',
            'expires_at' => Carbon::parse(
                $tokenResult->token->expires_at
            )->toDateTimeString()
        ]);
    }

    /*
     * Registro de usuarios
     */

    public function register(Request $request)
    {
        $request['confirmation_code'] = substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 30);

        $messages = [
            'required' => 'Por favor, asegúrese de rellenar los campos obligatorios',
            'unique' => 'El :attribute ya está registrado, por favor, vuelva a intentarlo con otras credenciales.',
        ];

        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
            'alias' => 'required|string',
            'surname' => 'required|string',
            'birthdate' => 'required|date',
            'sex' => 'required|string',
            'email' => 'required|string|email|unique:users',
            'password' => 'required|string'
        ], $messages);

        if ($validator->fails()) {
            $errors = $validator->errors()->first();

            return response()->json([
                'message' => $errors,
                'title' => 'Fallo en el registro'
            ], 422);
        }

        $category = Category::where('name', $request->category)->first();

        $user = new User;
        $user->name = $request->name;
        $user->alias = $request->alias;
        $user->surname = $request->surname;
        $user->birthdate = $request->birthdate;
        $user->sex = $request->sex;
        $user->email = $request->email;
        $user->description = $request->description;
        $user->phone = $request->phone;
        $user->password = bcrypt($request->password);
        $user->category_id = $category->id;
        $user->photo = $request->sex.'-default-img.png';
        $user->confirmation_code = $request['confirmation_code'];

       if (User::where('email', $user->email)->exists()) {
           return response()->json([
               'message' => 'Email Exist',
               'title' => 'Datos incorrectos'
           ], 422);
       }

        try {
            $data = ['name' => $request->name, 'confirmation_code' => $request['confirmation_code'], 'email' => $request->email];
			Mail::send('emails.confirmation_code', ['data' => $data], function($message) use ($data) {
                $message->from('register@glosita.com', 'Bienvenido a Glosita');
                $message->to($data['email'], $data['name'])->subject('Por favor confirma tu correo');
            });
        } catch (\Exception $e)
        {
            // echo $e;
            // dd($e);
            $errorMessage = $e->getMessage(); // Get the exception message

            return response()->json([
                'message' => $errorMessage,
                'title' => 'Datos incorrectos'
            ], 422);
        }

        $user->save();

        return response()->json([
            'message' => 'Successfully created user!'
        ], 201);
    }

    /*
     * Logout de usuarios
     */

    public function logout(Request $request)
    {
        $request->user()->active = false;
        $request->user()->save();

        $request->user()->token()->revoke();
        return response()->json([
            'message' => 'Successfully logged out'
        ]);
    }

    public function resetPassword(Request $request)
    {
        Log::info($request);
        $user = User::where('email', $request->email)->first();

        Log::info($user);

        if ($user) {

            $data = ['user' => $user];

            Mail::send('emails.reset_password', ['data' => $data], function($message) use ($data) {
                $message->from('support@glosita.com', 'Glosita');
                $message->to($data['user']->email, $data['user']->name)->subject('Recuperación de contraseña');
            });

            return response()->json([
                'message' => 'Email de recuperación enviado',
                'title' => 'Soporte de Glosita'
            ], 200);

        } else {
            return response()->json([
                'message' => 'Este email no está registrado en Glosita',
                'title' => 'Datos incorrectos'
            ], 422);
        }
    }

    /*
     * Obtener usuario auténticado
     */

    public function user(Request $request)
    {
        $user = $request->user();
        $category = Category::where('id',$user->category_id)->first();

        $user->category = $category;

        return response()->json($user);
    }

    public function chatuser(Request $request, $user_id)
    {
        $user = User::select('id', 'alias', 'name', 'surname', 'birthdate','sex','photo','position_lat','position_lng', 'active', 'category_id', 'visibility', 'description', 'blocked_users')->where('id', $user_id)->first();

        $category_selected = Category::where('id', $user->category_id)->first();

        $user->category = $category_selected->name;

        return response()->json($user);
    }

}
