<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use App\Model\Image;
use App\Model\Task;
use File;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * The Artisan commands provided by your application.
     *
     * @var array
     */
    protected $commands = [

    ];

    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {
        // $schedule->command('inspire')
        //          ->hourly();
        $schedule->call(function () {
            $images = Image::all();
            foreach($images as $image) {
                // dd($image->path['file']);
                if (!file_exists(public_path().$image->path['file'])) {
                    $image->tasks()->sync([]);
                    
                    $image->delete();
                }
            }
        })->everyMinute();
    }

    /**
     * Register the Closure based commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__.'/Commands');
        require base_path('routes/console.php');
    }
}
