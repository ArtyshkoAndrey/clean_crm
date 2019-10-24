<?php
use Illuminate\Database\Seeder;
use App\Model\User;
use App\Model\Task;
use Carbon\Carbon;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // User::create([
        //     'email' => 'artyshko.andrey@gmail.com',
        //     'name' => 'Артышко А. А.',
        //     'role' => 'admin',
        //     'password' => bcrypt('241298art')
        // ]);
        // User::create([
        //     'email' => 'artyshko.andrey1@gmail.com',
        //     'name' => 'Миронов М. М.',
        //     'role' => 'admin',
        //     'password' => bcrypt('241298art')
        // ]);
        Task::create([
            'user_id' => 1,
            'street' => 'Горького',
            'identified' => json_encode([1, 2]),
            'number_home' => '24',
            'description' => 'Пакет на дереве',
            'date_of_detection' => Carbon::parse('2019-10-21'),
            'responsible' => 'Сибгу им. Решетнева',
            'target_date' => Carbon::parse('2019-10-24')
        ]);
    }
}
