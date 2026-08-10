<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    use HasFactory;

    protected $primaryKey = 'payment_id';

    protected $fillable = [
        'bill_id',
        'amount',
        'payment_date',
    ];

    public function billing()
    {
        return $this->belongsTo(Billing::class,'bill_id','bill_id');
    }
}