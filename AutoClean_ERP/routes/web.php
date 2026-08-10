<?php

use App\Http\Controllers\CustomerController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\VehicleController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\BillingController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\ReportController;
use App\Models\Customer;
use App\Models\Vehicle;
use App\Models\Employee;
use App\Models\Billing;
Route::get('/', function () {
    return view('welcome');
});

Route::middleware(['auth'])->group(function () {

    Route::get('/dashboard', function () {

        $customerCount = Customer::count();

        $vehicleCount = Vehicle::count();

        $employeeCount = Employee::count();

        $todayIncome = Billing::whereDate('date', today())
            ->sum('total_amount');

        return view('dashboard', compact(
            'customerCount',
            'vehicleCount',
            'employeeCount',
            'todayIncome'
        ));

    })->name('dashboard');

    Route::get('/customers', [CustomerController::class, 'index'])
        ->name('customers.index');

    Route::get('/customers/create', [CustomerController::class, 'create'])->name('customers.create');

    Route::post('/customers', [CustomerController::class, 'store'])->name('customers.store');

    Route::get(
        '/customers/{customer}/edit',
        [CustomerController::class, 'edit']
    )
        ->name('customers.edit');

    Route::put(
        '/customers/{customer}',
        [CustomerController::class, 'update']
    )
        ->name('customers.update');

    Route::delete(
        '/customers/{customer}',
        [CustomerController::class, 'destroy']
    )
        ->name('customers.destroy');

    Route::get('/vehicles', [VehicleController::class, 'index'])->name('vehicles.index');

    Route::get('/vehicles/create', [VehicleController::class, 'create'])->name('vehicles.create');

    Route::post('/vehicles', [VehicleController::class, 'store'])->name('vehicles.store');

    Route::get('/vehicles/{vehicle}/edit', [VehicleController::class, 'edit'])->name('vehicles.edit');

    Route::put('/vehicles/{vehicle}', [VehicleController::class, 'update'])->name('vehicles.update');

    Route::delete('/vehicles/{vehicle}', [VehicleController::class, 'destroy'])->name('vehicles.destroy');

});



Route::get('/services', [ServiceController::class, 'index'])->name('services.index');
Route::get('/services/create', [ServiceController::class, 'create'])->name('services.create');
Route::post('/services', [ServiceController::class, 'store'])->name('services.store');
Route::get('/services/{service}/edit', [ServiceController::class, 'edit'])->name('services.edit');
Route::put('/services/{service}', [ServiceController::class, 'update'])->name('services.update');
Route::delete('/services/{service}', [ServiceController::class, 'destroy'])->name('services.destroy');


Route::get('/employees', [EmployeeController::class, 'index'])->name('employees.index');

Route::get('/employees/create', [EmployeeController::class, 'create'])->name('employees.create');

Route::post('/employees', [EmployeeController::class, 'store'])->name('employees.store');

Route::get('/employees/{employee}/edit', [EmployeeController::class, 'edit'])->name('employees.edit');

Route::put('/employees/{employee}', [EmployeeController::class, 'update'])->name('employees.update');

Route::delete('/employees/{employee}', [EmployeeController::class, 'destroy'])->name('employees.destroy');


Route::get('/billings', [BillingController::class, 'index'])->name('billings.index');

Route::get('/billings/create', [BillingController::class, 'create'])->name('billings.create');

Route::post('/billings', [BillingController::class, 'store'])->name('billings.store');

Route::get('/billings/{billing}/edit', [BillingController::class, 'edit'])->name('billings.edit');

Route::put('/billings/{billing}', [BillingController::class, 'update'])->name('billings.update');

Route::delete('/billings/{billing}', [BillingController::class, 'destroy'])->name('billings.destroy');



Route::get('/payments', [PaymentController::class, 'index'])->name('payments.index');

Route::get('/payments/create', [PaymentController::class, 'create'])->name('payments.create');

Route::post('/payments', [PaymentController::class, 'store'])->name('payments.store');

Route::get('/payments/{payment}/edit', [PaymentController::class, 'edit'])->name('payments.edit');

Route::put('/payments/{payment}', [PaymentController::class, 'update'])->name('payments.update');

Route::delete('/payments/{payment}', [PaymentController::class, 'destroy'])->name('payments.destroy');



Route::get('/reports', [ReportController::class, 'index'])
    ->name('reports.index');

require __DIR__ . '/auth.php';