<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Profile extends Model
{
    protected $with = ['department'];
    
    public function department() {  
        return $this->belongsTo('App\Model\Departments', 'department_id', 'id');
    }
}
