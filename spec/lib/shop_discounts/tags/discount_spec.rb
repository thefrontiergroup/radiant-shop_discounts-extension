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

  describe 'shop:discount:total_price_with_discount' do

    it 'should output the total price of the products minus discount' do
      tag = %{<r:shop:discount name="bread box discount"><r:total_price_with_discount/></r:shop:discount>}
      # First product is $10.00 second is $11.00 ($21 total) with 10% off is $18.90
      exp = %{$18.90}

      page.should render(tag).as(exp)
    end

  end

  describe 'shop:discount:total_price_without_discount' do

    it 'should output the total price of the products' do
      tag = %{<r:shop:discount name="bread box discount"><r:total_price_without_discount/></r:shop:discount>}
      # First product is $10.00 second is $11.00 = $21 total
      exp = %{$21.00}

      page.should render(tag).as(exp)
    end

  end

  describe 'shop:discount:name' do

    it 'should output the total price of the products' do
      tag = %{<r:shop:discount name="bread box discount"><r:name/></r:shop:discount>}
      exp = %{bread box discount}

      page.should render(tag).as(exp)
    end

  end

  describe 'shop:discount:products:each' do
    it 'expands the tag' do
      tag = %{<r:shop:discount name="bread box discount"><r:products:each>lollipop </r:products:each></r:shop:discount>}
      # There are 2 products so it should loop twice
      exp = 'lollipop lollipop '

      page.should render(tag).as(exp)
    end
  end

  describe 'shop:discount:products:each:name' do
    it 'expands the tag' do
      tag = %{<r:shop:discount name="bread box discount"><r:products:each><r:name/> </r:products:each></r:shop:discount>}
      exp = 'soft bread crusty bread '

      page.should render(tag).as(exp)
    end
  end

  describe 'shop:discount:products:each:description' do
    it 'expands the tag' do
      tag = %{<r:shop:discount name="bread box discount"><r:products:each><r:description/> </r:products:each></r:shop:discount>}
      exp = '*soft bread* *crusty bread* '

      page.should render(tag).as(exp)
    end
  end


end
