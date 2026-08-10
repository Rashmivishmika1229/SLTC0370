@extends('adminlte::page')

@section('title','Edit Vehicle')

@section('content_header')
<h1>Edit Vehicle</h1>
@stop

@section('content')

<div class="card">

    <div class="card-header">
        <h3>Edit Vehicle</h3>
    </div>

    <div class="card-body">

        <form action="{{ route('vehicles.update',$vehicle->vehicle_id) }}" method="POST">

            @csrf
            @method('PUT')

            <div class="form-group mb-3">

                <label>Customer</label>

                <select name="customer_id" class="form-control">

                    @foreach($customers as $customer)

                        <option value="{{ $customer->customer_id }}"
                        {{ $customer->customer_id == $vehicle->customer_id ? 'selected' : '' }}>

                            {{ $customer->name }}

                        </option>

                    @endforeach

                </select>

            </div>

            <div class="form-group mb-3">

                <label>Vehicle Type</label>

                <input type="text"
                       class="form-control"
                       name="vehicle_type"
                       value="{{ $vehicle->vehicle_type }}">

            </div>

            <div class="form-group mb-3">

                <label>Vehicle Number</label>

                <input type="text"
                       class="form-control"
                       name="vehicle_number"
                       value="{{ $vehicle->vehicle_number }}">

            </div>

            <button class="btn btn-danger">
                Update Vehicle
            </button>

            <a href="{{ route('vehicles.index') }}"
               class="btn btn-secondary">

                Cancel

            </a>

        </form>

    </div>

</div>

@stop