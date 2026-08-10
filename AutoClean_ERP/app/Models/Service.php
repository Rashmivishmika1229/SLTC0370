<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
    use HasFactory;

    protected $primaryKey = 'service_id';

    protected $fillable = [
        'service_name',
        'price',
    ];


    public function billings()
    {
        return $this->hasMany(Billing::class, 'service_id', 'service_id');
    }
}