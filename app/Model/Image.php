<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    protected $casts = ['path' => 'array'];
    protected $fillable = ['path'];

    public function tasks () {
        return $this->belongsToMany('App\Model\Task', 'task_images', 'image_id', 'task_id');
    }
}
