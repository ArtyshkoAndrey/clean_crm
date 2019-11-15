<?php

use Illuminate\Database\Seeder;

class ConnectRelationshipsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        /**
         * Get Available Permissions.
         */
        $permissions = config('roles.models.permission')::all();

        /**
         * Attach Permissions to Roles.
         */
        $roleAdmin = config('roles.models.role')::where('name', '=', 'Admin')->first();
        foreach ($permissions as $permission) {
            $roleAdmin->attachPermission($permission);
        }

        $roleModerate = config('roles.models.role')::where('name', '=', 'Manager')->first();
        $roleUser = config('roles.models.role')::where('name', '=', 'User')->first();
        foreach ($permissions as $permission) {
            if ($permission->slug !== 'edit.users' || $permission->slug !== 'create.users' || $permission->slug !== 'delete.users' || $permission->slug !== 'delete.problems') {
                $roleModerate->attachPermission($permission);
                $roleUser->attachPermission($permission);
            }
        }
    }
}
