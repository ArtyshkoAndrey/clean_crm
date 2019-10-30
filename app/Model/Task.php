<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Task extends Model {

  protected $casts = [
    'target_date'  => 'date:d.m.Y',
    'detection_date' => 'date:d.m.Y',
    'correction_date' => 'date:d.m.Y'
  ];

  protected $with = ['identified', 'responsible', 'images'];

  public function user () {
    return $this->belongsTo('App\Model\User');
  }

  public function identified () {
    return $this->belongsToMany('App\Model\User', 'user_tasks', 'task_id', 'user_id');
  }

  public function images () {
    return $this->belongsToMany('App\Model\Image', 'task_images', 'task_id', 'image_id');
  }

  public function responsible () {
    return $this->belongsTo('App\Model\Responsible');
  }
}
