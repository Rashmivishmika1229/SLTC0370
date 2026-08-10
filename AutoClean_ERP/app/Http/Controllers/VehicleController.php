<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use App\Models\Vehicle;
use Illuminate\Http\Request;

class VehicleController extends Controller
{
    public function index(Request $request)
    {
        $search = $request->search;

        $query = Vehicle::with('customer');

        if ($search) {
            $query->where('vehicle_type', 'LIKE', "%{$search}%")
                ->orWhere('vehicle_number', 'LIKE', "%{$search}%");
        }

        $vehicles = $query->get();

        return view('vehicles.index', compact('vehicles', 'search'));
    }

    public function create()
    {
        $customers = Customer::all();

        return view('vehicles.create', compact('customers'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'customer_id' => 'required',
            'vehicle_type' => 'required',
            'vehicle_number' => 'required',
        ]);

        Vehicle::create($request->all());

        return redirect()
            ->route('vehicles.index')
            ->with('success', 'Vehicle added successfully.');
    }


    public function edit($id)
    {
        $vehicle = Vehicle::findOrFail($id);
        $customers = Customer::all();

        return view('vehicles.edit', compact('vehicle', 'customers'));
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'customer_id' => 'required',
            'vehicle_type' => 'required',
            'vehicle_number' => 'required',
        ]);

        $vehicle = Vehicle::findOrFail($id);

        $vehicle->update([
            'customer_id' => $request->customer_id,
            'vehicle_type' => $request->vehicle_type,
            'vehicle_number' => strtoupper($request->vehicle_number),
        ]);

        return redirect()
            ->route('vehicles.index')
            ->with('success', 'Vehicle updated successfully.');
    }

    public function destroy($id)
    {
        $vehicle = Vehicle::findOrFail($id);

        $vehicle->delete();

        return redirect()
            ->route('vehicles.index')
            ->with('success', 'Vehicle deleted successfully.');
    }
}