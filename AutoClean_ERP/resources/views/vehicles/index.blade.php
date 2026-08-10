@extends('adminlte::page')

@section('title', 'Vehicles')

@section('content_header')
    <h1 class="font-weight-bold text-dark">
        VEHICLE MANAGEMENT
    </h1>
@stop

@section('content')

@if(session('success'))
    <div class="alert alert-success">
        {{ session('success') }}
    </div>
@endif

<div class="card">

    <div class="card-header">

        <h3 class="card-title">Vehicle List</h3>

        <div class="card-tools">
            <a href="{{ route('vehicles.create') }}" class="btn btn-danger">
                <i class="fas fa-plus"></i> Add Vehicle
            </a>
        </div>

    </div>

    <div class="card-body">

        <div class="row mb-3">

            <div class="col-md-6">

                <form action="{{ route('vehicles.index') }}" method="GET">

                    <div class="input-group">

                        <input type="text" name="search" class="form-control" placeholder="Search vehicle..."
                            value="{{ request('search') }}">

                        <button class="btn btn-danger">
                            <i class="fas fa-search"></i> Search
                        </button>

                    </div>

                </form>

            </div>

        </div>

        <table class="table table-bordered table-striped">

            <thead>

                <tr>
                    <th>ID</th>
                    <th>Customer</th>
                    <th>Vehicle Type</th>
                    <th>Vehicle Number</th>
                    <th width="170">Actions</th>
                </tr>

            </thead>

            <tbody>

                @forelse($vehicles as $vehicle)

                    <tr>

                        <td>{{ $vehicle->vehicle_id }}</td>

                        <td>{{ $vehicle->customer->name }}</td>

                        <td>{{ $vehicle->vehicle_type }}</td>

                        <td>{{ $vehicle->vehicle_number }}</td>

                        <td>

                            <a href="{{ route('vehicles.edit', $vehicle->vehicle_id) }}" class="btn btn-warning btn-sm">

                                <i class="fas fa-edit"></i> Edit

                            </a>

                            <form action="{{ route('vehicles.destroy', $vehicle->vehicle_id) }}" method="POST"
                                style="display:inline;">

                                @csrf
                                @method('DELETE')

                                <button class="btn btn-danger btn-sm" onclick="return confirm('Delete this vehicle?')">

                                    <i class="fas fa-trash"></i> Delete

                                </button>

                            </form>

                        </td>

                    </tr>

                @empty

                    <tr>

                        <td colspan="5" class="text-center">
                            No vehicles found.
                        </td>

                    </tr>

                @endforelse

            </tbody>

        </table>

    </div>

</div>

@stop