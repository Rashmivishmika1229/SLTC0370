<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    use HasFactory;

    protected $primaryKey = 'customer_id';

    protected $fillable = [
        'name',
        'contact_number',
        'address',
    ];

    public function vehicles()
    {
        return $this->hasMany(Vehicle::class, 'customer_id', 'customer_id');
    }

    public function billings()
    {
        return $this->hasMany(Billing::class, 'customer_id', 'customer_id');
    }


}