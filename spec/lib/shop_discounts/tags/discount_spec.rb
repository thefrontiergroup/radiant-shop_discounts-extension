require 'spec_helper'

describe ShopDiscounts::Tags::Discount do

  dataset :pages, :shop_orders, :shop_line_items, :shop_discounts, :shop_discountables

  let(:cart)                { shop_orders(:empty) }
  let(:page)                { pages(:home) }
  let!(:bread_box_discount) { shop_discounts(:bread_box_discount) }

  before do
    stub(Shop::Tags::Helpers).current_order(anything) { cart }
  end

  describe 'shop:discount' do

    it 'should expand if there is a matching discount' do
      tag = %{<r:shop:discount name="bread box discount">inner</r:shop:discount>}
      exp = %{inner}

      page.should render(tag).as(exp)
    end

    it 'should not expand if no discount matches' do
      tag = %{<r:shop:discount name="non existant discount">inner</r:shop:discount>}
      exp = %{}

      page.should render(tag).as(exp)
    end

  end

  describe 'shop:discount:total_price' do

    it 'should output the total price of the products minus discount' do
      tag = %{<r:shop:discount name="bread box discount"><r:total_price/></r:shop:discount>}
      # First product is $10.00 second is $11.00 ($21 total) with 10% off is $18.90
      exp = %{$18.90}

      page.should render(tag).as(exp)
    end

  end

end
