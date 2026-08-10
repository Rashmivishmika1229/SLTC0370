@extends('adminlte::page')

@section('title', 'Billing')

@section('content_header')
    <h1 class="font-weight-bold text-dark">
        BILLING MANAGEMENT
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

        <h3 class="card-title">Billing List</h3>

        <div class="card-tools">

            <a href="{{ route('billings.create') }}" class="btn btn-danger">
                <i class="fas fa-plus"></i> Create Bill
            </a>

        </div>

    </div>

    <div class="card-body">

        <table class="table table-bordered table-striped">

            <thead>

            <tr>

                <th>ID</th>
                <th>Customer</th>
                <th>Vehicle</th>
                <th>Service</th>
                <th>Date</th>
                <th>Total (Rs.)</th>
                <th width="170">Actions</th>

            </tr>

            </thead>

            <tbody>

            @forelse($billings as $billing)

                <tr>

                    <td>{{ $billing->bill_id }}</td>

                    <td>{{ $billing->customer->name }}</td>

                    <td>{{ $billing->vehicle->vehicle_number }}</td>

                    <td>{{ $billing->service->service_name }}</td>

                    <td>{{ $billing->date }}</td>

                    <td>{{ number_format($billing->total_amount,2) }}</td>

                    <td>

                        <a href="{{ route('billings.edit',$billing->bill_id) }}"
                           class="btn btn-warning btn-sm">

                            <i class="fas fa-edit"></i> Edit

                        </a>

                        <form action="{{ route('billings.destroy',$billing->bill_id) }}"
                              method="POST"
                              style="display:inline;">

                            @csrf
                            @method('DELETE')

                            <button class="btn btn-danger btn-sm"
                                    onclick="return confirm('Delete this bill?')">

                                <i class="fas fa-trash"></i> Delete

                            </button>

                        </form>

                    </td>

                </tr>

            @empty

                <tr>

                    <td colspan="7" class="text-center">
                        No bills found.
                    </td>

                </tr>

            @endforelse

            </tbody>

        </table>

    </div>

</div>

@stop