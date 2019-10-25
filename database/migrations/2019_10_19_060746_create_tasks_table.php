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
            $table->integer('user_id'); // Кто создал
            $table->text('name'); // Название задачи
            $table->string('street'); // Улица
            $table->string('number_home'); // Номер дома
            $table->text('description'); // Описание
            $table->date('date_of_detection'); // Дата обналужения
            // $table->text('identified'); // Кем выявлено Отношения многие ко многим
            $table->integer('responsible_id'); // Ответственный Отношения Один к одному В таске id ответ. А отв. в отдельной таблице.
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
