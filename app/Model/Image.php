<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    protected $casts = ['path' => 'array'];
    protected $fillable = ['path'];
}
