<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Task extends Model {

  protected $casts = [
    'target_date'  => 'date:d.m.Y',
    'date_of_detection' => 'date:d.m.Y',
    'correction_date' => 'date:d.m.Y'
  ];

  public function user() {
    return $this->belongsTo('App\Model\User');
  }
}
