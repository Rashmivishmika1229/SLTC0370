@extends('adminlte::page')



@section('title', 'Customers')

@section('content_header')
    <h1 class="font-weight-bold text-dark">
        CUSTOMER MANAGEMENT
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
        <h3 class="card-title">Customer List</h3>

        <div class="card-tools">
            <a href="{{ route('customers.create') }}" class="btn btn-danger">
                <i class="fas fa-plus"></i> Add Customer
            </a>
        </div>
    </div>

    <div class="card-body">

        <div class="row mb-3">

            <div class="col-md-6">

                <form action="{{ route('customers.index') }}" method="GET">

                    <div class="input-group">

                        <input type="text" name="search" class="form-control" placeholder="Search customer..."
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
                    <th>Name</th>
                    <th>Contact Number</th>
                    <th>Address</th>
                    <th width="170">Actions</th>
                </tr>
            </thead>

            <tbody>

                @forelse($customers as $customer)

                    <tr>
                        <td>{{ $customer->customer_id }}</td>
                        <td>{{ $customer->name }}</td>
                        <td>{{ $customer->contact_number }}</td>
                        <td>{{ $customer->address }}</td>
                        

                        <td>

                            <a href="{{ route('customers.edit', $customer->customer_id) }}" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i> Edit
                            </a>

                            <form action="{{ route('customers.destroy', $customer->customer_id) }}" method="POST"
                                style="display:inline;">

                                @csrf
                                @method('DELETE')

                                <button type="submit" class="btn btn-danger btn-sm"
                                    onclick="return confirm('Are you sure you want to delete this customer?')">

                                    <i class="fas fa-trash"></i> Delete

                                </button>

                            </form>

                        </td>


                    </tr>

                @empty

                    <tr>
                        <td colspan="5" class="text-center">
                            No customers found.
                        </td>
                    </tr>

                @endforelse

            </tbody>

        </table>

    </div>
</div>

@stop