<?php

namespace App\Http\Controllers;

use App\Models\Billing;
use App\Models\Customer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ReportController extends Controller
{
    public function index(Request $request)
    {

      

        // Monthly Income Report
        $monthlyIncome = Billing::select(
            DB::raw("DATE_FORMAT(date, '%Y-%m') as month"),
            DB::raw("SUM(total_amount) as total_income")
        )
            ->groupBy('month')
            ->orderBy('month')
            ->get();

        // Service Report
        $serviceReport = Billing::with([
            'customer',
            'vehicle',
            'service'
        ])->get();

        // Customer History
        $customers = Customer::all();

        $customerHistory = collect();

        if ($request->customer_id) {

            $customerHistory = Billing::with([
                'customer',
                'vehicle',
                'service'
            ])
                ->where('customer_id', $request->customer_id)
                ->get();
        }

        return view('reports.index', compact(
            'monthlyIncome',
            'serviceReport',
            'customers',
            'customerHistory'
        ));
    }
}