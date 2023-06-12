class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new
  end

  def show
    @coupon = Coupon.find(params[:id])
    @merchant = Merchant.find(@coupon.merchant_id)
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

  def update
    coupon = Coupon.find(params[:id])
    if params[:status] == "0"
      coupon.update(status: 0)
      redirect_to merchant_coupon_path(coupon.merchant_id, coupon)
    elsif params[:status] == "1"
      coupon.update(status: 1)
      redirect_to merchant_coupon_path(coupon.merchant_id, coupon)
    else
      coupon.update(coupon_params)
      redirect_to merchant_coupon_path(coupon.merchant_id, coupon)
    end
  end

  private

  def coupon_params
    params.permit(:code, :name, :value, :coupon_type, :merchant_id)
  end
end