<?php

namespace App\Http\Controllers;

use App\Models\Billing;
use App\Models\Customer;
use App\Models\Vehicle;
use App\Models\Service;
use Illuminate\Http\Request;

class BillingController extends Controller
{
    public function index(Request $request)
    {
        $search = $request->search;

        $query = Billing::with(['customer', 'vehicle', 'service']);

        if ($search) {
            $query->whereHas('customer', function ($q) use ($search) {
                $q->where('name', 'LIKE', "%{$search}%");
            });
        }

        $billings = $query->get();

        return view('billings.index', compact('billings', 'search'));
    }

    public function create()
    {
        $customers = Customer::all();
        $vehicles = Vehicle::all();
        $services = Service::all();

        return view('billings.create', compact('customers', 'vehicles', 'services'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'customer_id' => 'required',
            'vehicle_id' => 'required',
            'service_id' => 'required',
            'date' => 'required|date',
            'total_amount' => 'required|numeric',
        ]);

        Billing::create($request->all());

        return redirect()
            ->route('billings.index')
            ->with('success', 'Bill created successfully.');
    }

    public function edit($id)
    {
        $billing = Billing::findOrFail($id);

        $customers = Customer::all();
        $vehicles = Vehicle::all();
        $services = Service::all();

        return view('billings.edit', compact(
            'billing',
            'customers',
            'vehicles',
            'services'
        ));
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'customer_id' => 'required',
            'vehicle_id' => 'required',
            'service_id' => 'required',
            'date' => 'required|date',
            'total_amount' => 'required|numeric',
        ]);

        $billing = Billing::findOrFail($id);

        $billing->update($request->all());

        return redirect()
            ->route('billings.index')
            ->with('success', 'Bill updated successfully.');
    }

    public function destroy($id)
    {
        $billing = Billing::findOrFail($id);

        $billing->delete();

        return redirect()
            ->route('billings.index')
            ->with('success', 'Bill deleted successfully.');
    }
}