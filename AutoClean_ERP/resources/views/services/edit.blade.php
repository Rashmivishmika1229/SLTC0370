@extends('adminlte::page')

@section('title','Edit Service')

@section('content_header')
<h1>Edit Service</h1>
@stop

@section('content')

<div class="card">

    <div class="card-header">
        <h3>Edit Service</h3>
    </div>

    <div class="card-body">

        <form action="{{ route('services.update',$service->service_id) }}" method="POST">

            @csrf
            @method('PUT')

            <div class="form-group mb-3">

                <label>Service Name</label>

                <input
                    type="text"
                    name="service_name"
                    class="form-control"
                    value="{{ $service->service_name }}"
                    required>

            </div>

            <div class="form-group mb-3">

                <label>Price (Rs.)</label>

                <input
                    type="number"
                    step="0.01"
                    name="price"
                    class="form-control"
                    value="{{ $service->price }}"
                    required>

            </div>

            <button class="btn btn-danger">
                Update Service
            </button>

            <a href="{{ route('services.index') }}"
               class="btn btn-secondary">

                Cancel

            </a>

        </form>

    </div>

</div>

@stop