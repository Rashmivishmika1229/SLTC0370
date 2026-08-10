<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
{
    Schema::create('billings', function (Blueprint $table) {

        $table->id('bill_id');

        $table->unsignedBigInteger('customer_id');
        $table->unsignedBigInteger('vehicle_id');
        $table->unsignedBigInteger('service_id');

        $table->date('date');

        $table->decimal('total_amount', 10, 2);

        $table->timestamps();

        $table->foreign('customer_id')
              ->references('customer_id')
              ->on('customers')
              ->onDelete('cascade');

        $table->foreign('vehicle_id')
              ->references('vehicle_id')
              ->on('vehicles')
              ->onDelete('cascade');

        $table->foreign('service_id')
              ->references('service_id')
              ->on('services')
              ->onDelete('cascade');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('billings');
    }
};
