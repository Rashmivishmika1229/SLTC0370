@extends('adminlte::page')

@section('title','Edit Employee')

@section('content_header')
<h1>Edit Employee</h1>
@stop

@section('content')

<div class="card">

    <div class="card-header">
        <h3>Edit Employee</h3>
    </div>

    <div class="card-body">

        <form action="{{ route('employees.update',$employee->employee_id) }}" method="POST">

            @csrf
            @method('PUT')

            <div class="form-group mb-3">

                <label>Name</label>

                <input type="text"
                       name="name"
                       class="form-control"
                       value="{{ $employee->name }}"
                       required>

            </div>

            <div class="form-group mb-3">

                <label>Role</label>

                <input type="text"
                       name="role"
                       class="form-control"
                       value="{{ $employee->role }}"
                       required>

            </div>

            <div class="form-group mb-3">

                <label>Contact</label>

                <input type="text"
                       name="contact"
                       class="form-control"
                       value="{{ $employee->contact }}"
                       required>

            </div>

            <button class="btn btn-danger">
                Update Employee
            </button>

            <a href="{{ route('employees.index') }}"
               class="btn btn-secondary">

                Cancel

            </a>

        </form>

    </div>

</div>

@stop