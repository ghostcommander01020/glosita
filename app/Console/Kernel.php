<?php

namespace App\Console;

use App\User;
use DateTime;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class Kernel extends ConsoleKernel
{
    /**
     * The Artisan commands provided by your application.
     *
     * @var array
     */
    protected $commands = [
        //
    ];

    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {
        $schedule->call(function () {

            $users = User::where('active', 1)->get();
            $actually_date = new DateTime(date("Y-m-d H:i:s"));

            foreach ($users as $user) {
                Log::info($user);
                if ($user->im_here != null) {
                    $last_user_ping = new DateTime($user->im_here);

                    $interval = $actually_date->diff($last_user_ping);

                    $minutes = $interval->days * 24 * 60;
                    $minutes += $interval->h * 60;
                    $minutes += $interval->i;

                    if ($minutes >= 3) {
                        $user->active = 0;
                        $user->save();
                    }
                }
            }

        })->name('Is user active?')->withoutOverlapping()->everyMinute();
    }

    /**
     * Register the commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__ . '/Commands');

        require base_path('routes/console.php');
    }
}
