@extends('adminlte::page')

@section('title','Add Service')

@section('content_header')
<h1>Add Service</h1>
@stop

@section('content')

<div class="card">

    <div class="card-header">
        <h3>Add Service</h3>
    </div>

    <div class="card-body">

        <form action="{{ route('services.store') }}" method="POST">

            @csrf

            <div class="form-group mb-3">

                <label>Service Name</label>

                <input
                    type="text"
                    name="service_name"
                    class="form-control"
                    required>

            </div>

            <div class="form-group mb-3">

                <label>Price (Rs.)</label>

                <input
                    type="number"
                    step="0.01"
                    name="price"
                    class="form-control"
                    required>

            </div>

            <button class="btn btn-danger">
                Save Service
            </button>

            <a href="{{ route('services.index') }}"
               class="btn btn-secondary">

                Cancel

            </a>

        </form>

    </div>

</div>

@stop