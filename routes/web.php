<?php

use App\Http\Controllers\ContactController;
use App\Mail\MyTestEmail;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Mail;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/contact', [ContactController::class, 'index'])->name('contact.index');
Route::post('/contact', [ContactController::class, 'send'])->name('contact.send');

Route::get('/test', function() {
    $name = "Funny Coder";

    // The email sending is done using the to method on the Mail facade
    Mail::to("magno.luis42@hotmail.com")->send(new MyTestEmail($name));
});
