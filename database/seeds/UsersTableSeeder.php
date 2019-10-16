<?php
use Illuminate\Database\Seeder;
use App\User;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create([
            'email' => 'artyshko.andrey@gmail.com',
            'name' => 'Артышко А. А.',
            'role' => 'admin',
            'password' => bcrypt('241298art')
        ]);
    }
}
