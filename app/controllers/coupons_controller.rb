class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    coupon = @merchant.coupons.new(coupon_params)
    if coupon.save
      redirect_to merchant_coupons_path(@merchant)
    elsif coupon.errors[:code].include?("has already been taken")
      flash[:alert] = "Coupon code already exists"
      redirect_to new_merchant_coupon_path(@merchant)
    else
      redirect_to new_merchant_coupon_path(@merchant)
      flash[:alert] = "Please fill out all fields"
    end
  end

  private

  def coupon_params
    params.permit(:code, :name, :value, :coupon_type, :merchant_id)
  end
end