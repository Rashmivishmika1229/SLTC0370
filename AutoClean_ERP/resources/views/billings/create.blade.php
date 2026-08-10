@extends('adminlte::page')

@section('title','Create Bill')

@section('content_header')
<h1>Create Bill</h1>
@stop

@section('content')

<div class="card">

<div class="card-header">
<h3>Create New Bill</h3>
</div>

<div class="card-body">

<form action="{{ route('billings.store') }}" method="POST">

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

<label>Vehicle</label>

<select name="vehicle_id" class="form-control" required>

<option value="">Select Vehicle</option>

@foreach($vehicles as $vehicle)

<option value="{{ $vehicle->vehicle_id }}">

{{ $vehicle->vehicle_number }}

</option>

@endforeach

</select>

</div>

<div class="form-group mb-3">

<label>Service</label>

<select id="serviceSelect" name="service_id" class="form-control" required>

<option value="">Select Service</option>

@foreach($services as $service)

<option value="{{ $service->service_id }}"
        data-price="{{ $service->price }}">

{{ $service->service_name }}

</option>

@endforeach

</select>

</div>

<div class="form-group mb-3">

<label>Date</label>

<input type="date"
       name="date"
       class="form-control"
       required>

</div>

<div class="form-group mb-3">

<label>Total Amount (Rs.)</label>

<input type="number"
       step="0.01"
       id="totalAmount"
       name="total_amount"
       class="form-control"
       readonly>

</div>

<button class="btn btn-danger">

Save Bill

</button>

<a href="{{ route('billings.index') }}"
class="btn btn-secondary">

Cancel

</a>

</form>

</div>

</div>

<script>
document.getElementById('serviceSelect').addEventListener('change', function () {

    let price = this.options[this.selectedIndex].dataset.price;

    document.getElementById('totalAmount').value = price ?? '';

});
</script>

@stop