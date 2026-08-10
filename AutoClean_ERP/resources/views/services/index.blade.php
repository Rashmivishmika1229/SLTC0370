@extends('adminlte::page')

@section('title', 'Services')

@section('content_header')
    <h1 class="font-weight-bold text-dark">
        SERVICE MANAGEMENT
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

        <h3 class="card-title">Service List</h3>

        <div class="card-tools">

            <a href="{{ route('services.create') }}" class="btn btn-danger">
                <i class="fas fa-plus"></i> Add Service
            </a>

        </div>

    </div>

    <div class="card-body">

        <div class="row mb-3">

            <div class="col-md-6">

                <form action="{{ route('services.index') }}" method="GET">

                    <div class="input-group">

                        <input
                            type="text"
                            name="search"
                            class="form-control"
                            placeholder="Search service..."
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
                    <th>Service Name</th>
                    <th>Price (Rs.)</th>
                    <th width="170">Actions</th>

                </tr>

            </thead>

            <tbody>

                @forelse($services as $service)

                <tr>

                    <td>{{ $service->service_id }}</td>

                    <td>{{ $service->service_name }}</td>

                    <td>{{ number_format($service->price,2) }}</td>

                    <td>

                        <a href="{{ route('services.edit',$service->service_id) }}"
                           class="btn btn-warning btn-sm">

                            <i class="fas fa-edit"></i> Edit

                        </a>

                        <form action="{{ route('services.destroy',$service->service_id) }}"
                              method="POST"
                              style="display:inline;">

                            @csrf
                            @method('DELETE')

                            <button
                                class="btn btn-danger btn-sm"
                                onclick="return confirm('Delete this service?')">

                                <i class="fas fa-trash"></i> Delete

                            </button>

                        </form>

                    </td>

                </tr>

                @empty

                <tr>

                    <td colspan="4" class="text-center">
                        No services found.
                    </td>

                </tr>

                @endforelse

            </tbody>

        </table>

    </div>

</div>

@stop