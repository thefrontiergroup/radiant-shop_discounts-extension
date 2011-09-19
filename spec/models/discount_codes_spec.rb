require 'spec_helper'

# This is mixed into ShopLineItem so we are going to test ShopLineItem
# directly
describe ShopDiscounts::Models::DiscountCodes do

  dataset :shop_line_items, :shop_products, :shop_discounts

  context 'after save' do

    let(:shop_line_item) { shop_line_items(:one) }
    let(:shop_discount)  { shop_discounts(:ten_percent) } # Discount code: 10pcoff
    let(:item)           { shop_line_item.item }

    describe '#add_discounts' do

      context 'when the discount code matches an actual discount' do

        context 'when the discount applies to the product' do

          before :each do
            shop_line_item.discountables.destroy_all
            item.discountables.destroy_all
            item.discounts << shop_discount

            shop_line_item.discountables.destroy_all
            shop_line_item.update_attributes(:discount_code => '10pcoff')
          end

          it 'should add a discount' do
            shop_line_item.discounts.should include shop_discount
          end

        end

        context 'when the discount does not apply to the product' do

          before :each do
            shop_line_item.discountables.destroy_all
            item.discountables.destroy_all

            shop_line_item.discountables.destroy_all
            shop_line_item.update_attributes(:discount_code => '10pcoff')
          end

          it 'should not add a discount' do
            shop_line_item.discounts.should be_blank
          end

        end

      end

      context 'when the discount code does not match a discount' do

        before :each do
          shop_line_item.discountables.destroy_all
          shop_line_item.update_attributes(:discount_code => 'not_a_discount_code')
        end

        it 'should not add a discount' do
          shop_line_item.discounts.should be_blank
        end

      end

    end

  end


end
