<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Marker extends Model
{
    protected $fillable = [
        'title', 'info', 'tag_id', 'user_id', 'address', 'category_id', 'filters'
    ];

    public function tag()
    {
        return $this->belongsTo('App\Tag');
    }

    public function category()
    {
        return $this->belongsTo('App\Category');
    }

    public function user()
    {
        return $this->belongsTo('App\User');
    }
}
