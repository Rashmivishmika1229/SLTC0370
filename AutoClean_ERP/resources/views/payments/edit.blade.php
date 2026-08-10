@extends('adminlte::page')

@section('title','Edit Payment')

@section('content_header')
<h1>Edit Payment</h1>
@stop

@section('content')

<div class="card">

<div class="card-header">

<h3>Edit Payment</h3>

</div>

<div class="card-body">

<form action="{{ route('payments.update',$payment->payment_id) }}" method="POST">

@csrf
@method('PUT')

<div class="form-group mb-3">

<label>Bill</label>

<select id="billSelect"
        name="bill_id"
        class="form-control"
        required>

@foreach($billings as $billing)

<option value="{{ $billing->bill_id }}"
        data-amount="{{ $billing->total_amount }}"
        {{ $payment->bill_id==$billing->bill_id?'selected':'' }}>

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
       step="0.01"
       value="{{ $payment->amount }}">

</div>

<div class="form-group mb-3">

<label>Payment Date</label>

<input type="date"
       name="payment_date"
       class="form-control"
       value="{{ $payment->payment_date }}"
       required>

</div>

<button class="btn btn-danger">

Update Payment

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

document.getElementById('amount').value=amount;

});

window.onload=function(){

let select=document.getElementById('billSelect');

let amount=select.options[select.selectedIndex].dataset.amount;

document.getElementById('amount').value=amount;

};

</script>

@stop