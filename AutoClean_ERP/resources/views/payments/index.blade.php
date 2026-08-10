@extends('adminlte::page')

@section('title','Payments')

@section('content_header')
    <h1 class="font-weight-bold text-dark">
        PAYMENT MANAGEMENT
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

        <h3 class="card-title">Payment List</h3>

        <div class="card-tools">

            <a href="{{ route('payments.create') }}" class="btn btn-danger">
                <i class="fas fa-plus"></i> Add Payment
            </a>

        </div>

    </div>

    <div class="card-body">

        <table class="table table-bordered table-striped">

            <thead>

            <tr>

                <th>ID</th>
                <th>Bill ID</th>
                <th>Amount</th>
                <th>Payment Date</th>
                <th width="170">Actions</th>

            </tr>

            </thead>

            <tbody>

            @forelse($payments as $payment)

            <tr>

                <td>{{ $payment->payment_id }}</td>

                <td>{{ $payment->bill_id }}</td>

                <td>Rs. {{ number_format($payment->amount,2) }}</td>

                <td>{{ $payment->payment_date }}</td>

                <td>

                    <a href="{{ route('payments.edit',$payment->payment_id) }}"
                       class="btn btn-warning btn-sm">

                        <i class="fas fa-edit"></i> Edit

                    </a>

                    <form action="{{ route('payments.destroy',$payment->payment_id) }}"
                          method="POST"
                          style="display:inline;">

                        @csrf
                        @method('DELETE')

                        <button class="btn btn-danger btn-sm"
                            onclick="return confirm('Delete this payment?')">

                            <i class="fas fa-trash"></i> Delete

                        </button>

                    </form>

                </td>

            </tr>

            @empty

            <tr>

                <td colspan="5" class="text-center">

                    No payments found.

                </td>

            </tr>

            @endforelse

            </tbody>

        </table>

    </div>

</div>

@stop