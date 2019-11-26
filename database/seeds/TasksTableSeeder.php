<?php

use App\Model\UserTask;
use Illuminate\Database\Seeder;
use App\Model\Task;
use Carbon\Carbon;

class TasksTableSeeder extends Seeder
{
  /**
   * Run the database seeds.
   *
   * @return void
   */
  public function run() {
    $task = Task::create([
      'user_id' => 1,
      'name' => 'Пакетик',
      'street' => 'Горького',
      'number_home' => '24',
      'description' => 'Пакет на дереве',
      'responsible_executor' => 'ГЛухих',
      'detection_date' => Carbon::parse('2019-10-21'),
      'responsible_id' => 1,
      'target_date' => Carbon::parse('2019-10-24')
    ]);
    UserTask::create([
      'user_id' => 1,
      'task_id' => $task->id
    ]);
    UserTask::create([
      'user_id' => 2,
      'task_id' => $task->id
    ]);
  }

}
