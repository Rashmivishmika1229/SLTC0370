@extends('adminlte::page')

@section('title','Edit Bill')

@section('content_header')
<h1>Edit Bill</h1>
@stop

@section('content')

<div class="card">

    <div class="card-header">
        <h3>Edit Bill</h3>
    </div>

    <div class="card-body">

        <form action="{{ route('billings.update', $billing->bill_id) }}" method="POST">

            @csrf
            @method('PUT')

            <div class="form-group mb-3">

                <label>Customer</label>

                <select name="customer_id" class="form-control" required>

                    @foreach($customers as $customer)

                        <option value="{{ $customer->customer_id }}"
                            {{ $billing->customer_id == $customer->customer_id ? 'selected' : '' }}>

                            {{ $customer->name }}

                        </option>

                    @endforeach

                </select>

            </div>

            <div class="form-group mb-3">

                <label>Vehicle</label>

                <select name="vehicle_id" class="form-control" required>

                    @foreach($vehicles as $vehicle)

                        <option value="{{ $vehicle->vehicle_id }}"
                            {{ $billing->vehicle_id == $vehicle->vehicle_id ? 'selected' : '' }}>

                            {{ $vehicle->vehicle_number }}

                        </option>

                    @endforeach

                </select>

            </div>

            <div class="form-group mb-3">

                <label>Service</label>

                <select id="serviceSelect"
                        name="service_id"
                        class="form-control"
                        required>

                    @foreach($services as $service)

                        <option value="{{ $service->service_id }}"
                                data-price="{{ $service->price }}"
                                {{ $billing->service_id == $service->service_id ? 'selected' : '' }}>

                            {{ $service->service_name }}

                        </option>

                    @endforeach

                </select>

            </div>

            <div class="form-group mb-3">

                <label>Date</label>

                <input
                    type="date"
                    name="date"
                    class="form-control"
                    value="{{ $billing->date }}"
                    required>

            </div>

            <div class="form-group mb-3">

                <label>Total Amount (Rs.)</label>

                <input
                    type="number"
                    step="0.01"
                    id="totalAmount"
                    name="total_amount"
                    class="form-control"
                    value="{{ $billing->total_amount }}"
                    readonly>

            </div>

            <button class="btn btn-danger">

                Update Bill

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

    document.getElementById('totalAmount').value = price;

});

window.onload = function () {

    let select = document.getElementById('serviceSelect');

    let price = select.options[select.selectedIndex].dataset.price;

    document.getElementById('totalAmount').value = price;

};

</script>

@stop