<?php

namespace App\Http\Controllers;

use App\Models\Payment;
use App\Models\Billing;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    public function index(Request $request)
    {
        $search = $request->search;

        $query = Payment::with('billing');

        if ($search) {
            $query->where('bill_id', 'LIKE', "%{$search}%");
        }

        $payments = $query->get();

        return view('payments.index', compact('payments', 'search'));
    }

    public function create()
    {
        $billings = Billing::all();

        return view('payments.create', compact('billings'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'bill_id' => 'required',
            'amount' => 'required|numeric',
            'payment_date' => 'required|date',
        ]);

        Payment::create($request->all());

        return redirect()->route('payments.index')
            ->with('success', 'Payment added successfully.');
    }

    public function edit($id)
    {
        $payment = Payment::findOrFail($id);

        $billings = Billing::all();

        return view('payments.edit', compact('payment', 'billings'));
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'bill_id' => 'required',
            'amount' => 'required|numeric',
            'payment_date' => 'required|date',
        ]);

        $payment = Payment::findOrFail($id);

        $payment->update($request->all());

        return redirect()->route('payments.index')
            ->with('success', 'Payment updated successfully.');
    }

    public function destroy($id)
    {
        $payment = Payment::findOrFail($id);

        $payment->delete();

        return redirect()->route('payments.index')
            ->with('success', 'Payment deleted successfully.');
    }
}