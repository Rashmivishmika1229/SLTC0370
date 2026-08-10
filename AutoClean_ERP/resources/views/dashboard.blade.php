@extends('adminlte::page')

@section('title', 'Dashboard')

@section('content_header')
<h1 class="font-weight-bold text-dark">
    DASHBOARD
</h1>
@stop

@section('content')

<div class="row">

    <!-- Customers -->
    <div class="col-lg-6 col-md-6 mb-4">
        <div class="card bg-danger text-white shadow dashboard-card">
            <div class="card-body text-center">
                <h1>{{ $customerCount }}</h1>
                <h3>Customers</h3>
            </div>
        </div>
    </div>

    <!-- Vehicles -->
    <div class="col-lg-6 col-md-6 mb-4">
        <div class="card bg-danger text-white shadow dashboard-card">
            <div class="card-body text-center">
                <h1>{{ $vehicleCount }}</h1>
                <h3>Vehicles</h3>
            </div>
        </div>
    </div>

    <!-- Employees -->
    <div class="col-lg-6 col-md-6 mb-4">
        <div class="card bg-danger text-white shadow dashboard-card">
            <div class="card-body text-center">
                <h1>{{ $employeeCount }}</h1>
                <h3>Employees</h3>
            </div>
        </div>
    </div>

    <!-- Today's Income -->
    <div class="col-lg-6 col-md-6 mb-4">
        <div class="card bg-danger text-white shadow dashboard-card">
            <div class="card-body text-center">
                <h2>Rs. {{ number_format($todayIncome,2) }}</h2>
                <h3>Today's Income</h3>
            </div>
        </div>
    </div>

</div>

<style>

.dashboard-card{
    height:200px;
    border:none;
    border-radius:15px;
    box-shadow:0 8px 18px rgba(0,0,0,.15);
    transition:.3s;
}

.dashboard-card:hover{
    transform:translateY(-4px);
}

.dashboard-card .card-body{
    height:100%;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
}

.dashboard-card h1{
    font-size:65px;
    font-weight:bold;
    margin-bottom:12px;
}

.dashboard-card h2{
    font-size:42px;
    font-weight:bold;
    margin-bottom:12px;
}

.dashboard-card h3{
    font-size:24px;
    font-weight:500;
    margin:0;
}

</style>

@stop