@extends('adminlte::page')

@section('title', 'Employees')

@section('content_header')
    <h1 class="font-weight-bold text-dark">
        EMPLOYEE MANAGEMENT
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

        <h3 class="card-title">Employee List</h3>

        <div class="card-tools">

            <a href="{{ route('employees.create') }}" class="btn btn-danger">
                <i class="fas fa-plus"></i> Add Employee
            </a>

        </div>

    </div>

    <div class="card-body">

        <div class="row mb-3">

            <div class="col-md-6">

                <form action="{{ route('employees.index') }}" method="GET">

                    <div class="input-group">

                        <input type="text"
                               name="search"
                               class="form-control"
                               placeholder="Search employee..."
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
                    <th>Role</th>
                    <th>Contact</th>
                    <th width="170">Actions</th>

                </tr>

            </thead>

            <tbody>

                @forelse($employees as $employee)

                <tr>

                    <td>{{ $employee->employee_id }}</td>
                    <td>{{ $employee->name }}</td>
                    <td>{{ $employee->role }}</td>
                    <td>{{ $employee->contact }}</td>

                    <td>

                        <a href="{{ route('employees.edit',$employee->employee_id) }}"
                           class="btn btn-warning btn-sm">

                            <i class="fas fa-edit"></i> Edit

                        </a>

                        <form action="{{ route('employees.destroy',$employee->employee_id) }}"
                              method="POST"
                              style="display:inline;">

                            @csrf
                            @method('DELETE')

                            <button class="btn btn-danger btn-sm"
                                    onclick="return confirm('Delete this employee?')">

                                <i class="fas fa-trash"></i> Delete

                            </button>

                        </form>

                    </td>

                </tr>

                @empty

                <tr>

                    <td colspan="5" class="text-center">
                        No employees found.
                    </td>

                </tr>

                @endforelse

            </tbody>

        </table>

    </div>

</div>

@stop