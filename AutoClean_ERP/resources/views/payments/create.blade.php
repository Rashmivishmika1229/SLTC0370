@extends('adminlte::page')

@section('title','Add Payment')

@section('content_header')
<h1>Add Payment</h1>
@stop

@section('content')

<div class="card">

<div class="card-header">

<h3>Add Payment</h3>

</div>

<div class="card-body">

<form action="{{ route('payments.store') }}" method="POST">

@csrf

<div class="form-group mb-3">

<label>Bill</label>

<select id="billSelect"
        name="bill_id"
        class="form-control"
        required>

<option value="">Select Bill</option>

@foreach($billings as $billing)

<option value="{{ $billing->bill_id }}"
        data-amount="{{ $billing->total_amount }}">

Bill #{{ $billing->bill_id }}
-
{{ $billing->customer->name }}
-
{{ $billing->vehicle->vehicle_number }}

</option>

@endforeach

</select>

</div>

<div class="form-group mb-3">

<label>Amount</label>

<input type="number"
       id="amount"
       name="amount"
       class="form-control"
       readonly
       step="0.01">

</div>

<div class="form-group mb-3">

<label>Payment Date</label>

<input type="date"
       name="payment_date"
       class="form-control"
       required>

</div>

<button class="btn btn-danger">

Save Payment

</button>

<a href="{{ route('payments.index') }}"
class="btn btn-secondary">

Cancel

</a>

</form>

</div>

</div>

<script>

document.getElementById('billSelect').addEventListener('change',function(){

let amount=this.options[this.selectedIndex].dataset.amount;

document.getElementById('amount').value=amount ?? '';

});

</script>

@stop