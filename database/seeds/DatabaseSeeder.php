<?php

use Illuminate\Database\Seeder;
use App\Tag;
use App\Category;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        /*
         * Categorías
         */

        $category_date = Category::create([
            'name' => 'date',
            'logo' => 'heart'
        ]);

        $category_transport = Category::create([
            'name' => 'transport',
            'logo' => 'car'
        ]);

        $category_rental = Category::create([
            'name' => 'rental',
            'logo' => 'house'
        ]);


        /*
         * Tags
         */

        $tag_date_1 = Tag::create([
            'name' => 'Male',
            'category_id' => 1
        ]);

        $tag_date_2 = Tag::create([
            'name' => 'Female',
            'category_id' => 1
        ]);

        $tag_date_3 = Tag::create([
            'name' => '<25',
            'category_id' => 1
        ]);

        $tag_date_4 = Tag::create([
            'name' => '25-35',
            'category_id' => 1
        ]);

        $tag_date_5 = Tag::create([
            'name' => '35-45',
            'category_id' => 1
        ]);

        $tag_date_6 = Tag::create([
            'name' => '>45',
            'category_id' => 1
        ]);

        $tag_transport = Tag::create([
            'name' => 'bablacar',
            'category_id' => 2
        ]);

        $tag_rental = Tag::create([
            'name' => 'chalet',
            'category_id' => 3
        ]);

    }
}
