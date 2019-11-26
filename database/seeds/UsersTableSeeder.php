<?php
use Illuminate\Database\Seeder;
use App\Model\User;
use App\Model\Task;
use Carbon\Carbon;
use App\Model\Responsible;
use App\Model\UserTask;

class UsersTableSeeder extends Seeder
{
  /**
   * Run the database seeds.
   *
   * @return void
   */
  public function run() {
    $admin = User::create([
      'email' => 'artyshko.andrey@gmail.com',
      'name' => 'Артышко А. А.',
      'password' => bcrypt('241298art'),
      'birthday' => Carbon::parse('1998-12-24'),
      'avatar' => 'https://sun9-49.userapi.com/c857132/v857132657/2d7ed/emmP4VZJXng.jpg',
    ]);
    $admin->attachRole(config('roles.models.role')::where('name', '=', 'Admin')->first());
    User::create([
      'email' => 'artyshko.andrey1@gmail.com',
      'name' => 'Миронов М. М.',
      'password' => bcrypt('241298art'),
      'birthday' => Carbon::parse('1998-12-24'),
      'avatar' => 'https://sun9-49.userapi.com/c857132/v857132657/2d7ed/emmP4VZJXng.jpg',
    ]);
    Responsible::create([
      'name' => 'Отдел экономики и развития местного самоуправления'
    ]);
    Responsible::create([
      'name' => 'Глухих Р.С.'
    ]);
    Responsible::create([
      'name' => 'Отдел по землепользованию и благоустройству района'
    ]);
    Responsible::create([
      'name' => 'Отдел жилищно-коммунального хозяйства'
    ]);
  }
}
