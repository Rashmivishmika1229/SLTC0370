@extends('adminlte::page')

@section('title','Add Employee')

@section('content_header')
<h1>Add Employee</h1>
@stop

@section('content')

<div class="card">

    <div class="card-header">
        <h3>Add Employee</h3>
    </div>

    <div class="card-body">

        <form action="{{ route('employees.store') }}" method="POST">

            @csrf

            <div class="form-group mb-3">

                <label>Name</label>

                <input type="text"
                       name="name"
                       class="form-control"
                       required>

            </div>

            <div class="form-group mb-3">

                <label>Role</label>

                <input type="text"
                       name="role"
                       class="form-control"
                       required>

            </div>

            <div class="form-group mb-3">

                <label>Contact</label>

                <input type="text"
                       name="contact"
                       class="form-control"
                       required>

            </div>

            <button class="btn btn-danger">
                Save Employee
            </button>

            <a href="{{ route('employees.index') }}"
               class="btn btn-secondary">

                Cancel

            </a>

        </form>

    </div>

</div>

@stop