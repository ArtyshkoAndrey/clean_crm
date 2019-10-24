<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTasksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tasks', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('user_id');
            $table->text('name');
            $table->string('street');
            $table->string('number_home');
            $table->text('description');
            $table->date('date_of_detection');
            $table->text('identified');
            $table->text('responsible');
            $table->date('target_date');
            $table->date('correction_date')->nullable();
            $table->text('responsible_executor')->nullable();
            $table->text('conducted_work')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tasks');
    }
}
