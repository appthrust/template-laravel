<?php
use Illuminate\Support\Facades\Route;
Route::get('/', fn () => response()->json(['service' => 'laravel', 'databaseConfigured' => env('DATABASE_URL') !== null]));
Route::get('/healthz', fn () => response('', 204));
