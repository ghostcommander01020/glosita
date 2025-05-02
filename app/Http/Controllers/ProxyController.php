<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class ProxyController extends Controller
{
    public function proxyToGoogleMaps(Request $request)
    {
        $lat = $request->input('lat');
        $lng = $request->input('lng');
        $apiKey = 'AIzaSyBsFep8DUbGlv6c65ReyzsnUlXGXhlFnG0'; // Replace with your API key
        $url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey";

        // Initialize cURL session
        $ch = curl_init($url);

        // Set cURL options
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); // Return response as a string
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true); // Follow redirects

        // Execute cURL session and get the response
        $response = curl_exec($ch);

        // Check for cURL errors
        if (curl_errno($ch)) {
            return response()->json(['error' => 'cURL Error: ' . curl_error($ch)], 500);
        }

        // Get HTTP status code
        $httpStatus = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        // Close cURL session
        curl_close($ch);

        // Check the HTTP status code
        if ($httpStatus === 200) {
            // Parse JSON response
            $data = json_decode($response, true);

            // Return the response to the client
            return response()->json($data);
        } else {
            return response()->json(['error' => 'HTTP request failed'], $httpStatus);
        }
    }

}

?>