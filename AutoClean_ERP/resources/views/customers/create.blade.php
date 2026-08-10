@extends('adminlte::page')

@section('title', 'Add Customer')

@section('content_header')
    <h1>Add Customer</h1>
@stop

@section('content')

<div class="card">

    <div class="card-header">
        <h3>Add New Customer</h3>
    </div>

    <div class="card-body">

        <form action="{{ route('customers.store') }}" method="POST">

            @csrf

            <div class="form-group mb-3">
                <label>Name</label>
                <input
                    type="text"
                    name="name"
                    class="form-control"
                    required>
            </div>

            <div class="form-group mb-3">
                <label>Contact Number</label>
                <input
                    type="text"
                    name="contact_number"
                    class="form-control"
                    required>
            </div>

            <div class="form-group mb-3">
                <label>Address</label>
                <textarea
                    name="address"
                    class="form-control"
                    rows="3"
                    required></textarea>
            </div>

            <button class="btn btn-danger">
                Save Customer
            </button>

            <a href="{{ route('customers.index') }}" class="btn btn-secondary">
                Cancel
            </a>

        </form>

    </div>

</div>

@stop