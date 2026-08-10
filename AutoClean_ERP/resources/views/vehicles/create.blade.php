@extends('adminlte::page')

@section('title','Add Vehicle')

@section('content_header')
<h1>Add Vehicle</h1>
@stop

@section('content')

<div class="card">

<div class="card-header">
<h3>Add Vehicle</h3>
</div>

<div class="card-body">

<form action="{{ route('vehicles.store') }}" method="POST">

@csrf

<div class="form-group mb-3">

<label>Customer</label>

<select name="customer_id" class="form-control" required>

<option value="">Select Customer</option>

@foreach($customers as $customer)

<option value="{{ $customer->customer_id }}">

{{ $customer->name }}

</option>

@endforeach

</select>

</div>

<div class="form-group mb-3">

<label>Vehicle Type</label>

<input type="text"
name="vehicle_type"
class="form-control"
required>

</div>

<div class="form-group mb-3">

<label>Vehicle Number</label>

<input type="text"
name="vehicle_number"
class="form-control"
required>

</div>

<button class="btn btn-danger">

Save Vehicle

</button>

<a href="{{ route('vehicles.index') }}"
class="btn btn-secondary">

Cancel

</a>

</form>

</div>

</div>

@stop