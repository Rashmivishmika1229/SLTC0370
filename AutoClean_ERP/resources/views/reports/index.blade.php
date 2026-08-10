@extends('adminlte::page')

@section('title', 'Reports')

@section('content_header')
    <h1 class="font-weight-bold text-dark">
        REPORT MANAGEMENT
    </h1>
@stop

@section('content')

<div class="container-fluid">

    <!-- Monthly Income Report -->
    <div class="card">

        <div class="card-header bg-danger text-white">
            <h3 class="card-title">Monthly Income Report</h3>
        </div>

        <div class="card-body">

            <table class="table table-bordered table-striped">

                <thead>

                <tr>
                    <th>Month</th>
                    <th>Total Income (Rs.)</th>
                </tr>

                </thead>

                <tbody>

                @forelse($monthlyIncome as $income)

                    <tr>

                        <td>{{ $income->month }}</td>

                        <td>{{ number_format($income->total_income,2) }}</td>

                    </tr>

                @empty

                    <tr>

                        <td colspan="2" class="text-center">

                            No data available.

                        </td>

                    </tr>

                @endforelse

                </tbody>

            </table>

        </div>

    </div>

    <br>

    <!-- Service Report -->

    <div class="card">

        <div class="card-header bg-primary text-white">
            <h3 class="card-title">Service Report</h3>
        </div>

        <div class="card-body">

            <table class="table table-bordered table-striped">

                <thead>

                <tr>

                    <th>Bill ID</th>
                    <th>Customer</th>
                    <th>Vehicle</th>
                    <th>Service</th>
                    <th>Date</th>
                    <th>Amount (Rs.)</th>

                </tr>

                </thead>

                <tbody>

                @forelse($serviceReport as $report)

                    <tr>

                        <td>{{ $report->bill_id }}</td>

                        <td>{{ $report->customer->name }}</td>

                        <td>{{ $report->vehicle->vehicle_number }}</td>

                        <td>{{ $report->service->service_name }}</td>

                        <td>{{ $report->date }}</td>

                        <td>{{ number_format($report->total_amount,2) }}</td>

                    </tr>

                @empty

                    <tr>

                        <td colspan="6" class="text-center">

                            No records found.

                        </td>

                    </tr>

                @endforelse

                </tbody>

            </table>

        </div>

    </div>

    <br>

    <!-- Customer History Report -->

    <div class="card">

        <div class="card-header bg-success text-white">
            <h3 class="card-title">Customer History Report</h3>
        </div>

        <div class="card-body">

            <form method="GET" action="{{ route('reports.index') }}">

                <div class="row">

                    <div class="col-md-6">

                        <select name="customer_id" class="form-control">

                            <option value="">Select Customer</option>

                            @foreach($customers as $customer)

                                <option value="{{ $customer->customer_id }}"
    {{ request('customer_id') == $customer->customer_id ? 'selected' : '' }}>
    {{ $customer->name }}
</option>

                            @endforeach

                        </select>

                    </div>

                    <div class="col-md-2">

                        <button type="submit" class="btn btn-danger">
    Search
</button>

                    </div>

                </div>

            </form>

            <br>

            <table class="table table-bordered table-striped">

                <thead>

                <tr>

                    <th>Date</th>
                    <th>Vehicle</th>
                    <th>Service</th>
                    <th>Amount (Rs.)</th>

                </tr>

                </thead>

                <tbody>

                @forelse($customerHistory as $history)

                    <tr>

                        <td>{{ $history->date }}</td>

                        <td>{{ $history->vehicle->vehicle_number }}</td>

                        <td>{{ $history->service->service_name }}</td>

                        <td>{{ number_format($history->total_amount,2) }}</td>

                    </tr>

                @empty

                    <tr>

                        <td colspan="4" class="text-center">

                            No records found.

                        </td>

                    </tr>

                @endforelse

                </tbody>

            </table>

        </div>

    </div>

</div>

@stop