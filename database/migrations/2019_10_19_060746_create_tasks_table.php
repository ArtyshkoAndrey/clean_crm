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
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->unsignedBigInteger('user_id')->nullable()->unsigned()->index(); // Кто создал
            $table->foreign('user_id')->references('id')->on('users')->onDelete('set null');
            $table->text('name'); // Название задачи
            $table->string('street'); // Улица
            $table->string('number_home'); // Номер дома
            $table->text('description'); // Описание
            $table->date('detection_date'); // Дата обналужения
            $table->unsignedBigInteger('responsible_id')->unsigned()->index()->nullable(); // Ответственный
            $table->foreign('responsible_id')->references('id')->on('responsibles')->onDelete('set null');
            $table->date('target_date'); // Когда должны выполнить
            $table->date('correction_date')->nullable(); // Дата когда выполнили
            $table->text('responsible_executor')->nullable(); // Кто выполнил
            $table->text('conducted_work')->nullable(); // Что именно сделали
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
