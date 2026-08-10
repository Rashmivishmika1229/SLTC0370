<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vehicle extends Model
{
    use HasFactory;

    protected $primaryKey = 'vehicle_id';

    protected $fillable = [
        'customer_id',
        'vehicle_type',
        'vehicle_number',
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id', 'customer_id');
    }


    public function billings()
    {
        return $this->hasMany(Billing::class, 'vehicle_id', 'vehicle_id');
    }
}