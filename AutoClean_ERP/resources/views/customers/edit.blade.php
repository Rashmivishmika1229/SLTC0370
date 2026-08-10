@extends('adminlte::page')

@section('title', 'Edit Customer')

@section('content_header')
    <h1>Edit Customer</h1>
@stop

@section('content')

<div class="card">

    <div class="card-header">
        <h3>Edit Customer</h3>
    </div>

    <div class="card-body">

        <form action="{{ route('customers.update', $customer->customer_id) }}" method="POST">

            @csrf
            @method('PUT')

            <div class="form-group mb-3">
                <label>Name</label>
                <input
                    type="text"
                    name="name"
                    class="form-control"
                    value="{{ $customer->name }}"
                    required>
            </div>

            <div class="form-group mb-3">
                <label>Contact Number</label>
                <input
                    type="text"
                    name="contact_number"
                    class="form-control"
                    value="{{ $customer->contact_number }}"
                    required>
            </div>

            <div class="form-group mb-3">
                <label>Address</label>
                <textarea
                    name="address"
                    class="form-control"
                    rows="3"
                    required>{{ $customer->address }}</textarea>
            </div>

            <button type="submit" class="btn btn-warning">
                Update Customer
            </button>

            <a href="{{ route('customers.index') }}" class="btn btn-secondary">
                Cancel
            </a>

        </form>

    </div>

</div>

@stop