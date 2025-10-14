<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class MarkerPhotos extends Model
{
    protected $fillable = [
        'name', 'marker_id'
    ];

    public function marker()
    {
        return $this->hasOne('App\Marker');
    }
}
