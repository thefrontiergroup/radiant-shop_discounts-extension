require 'spec/spec_helper'

describe ShopOrder do
  dataset :shop_orders, :shop_line_items, :shop_discountables, :shop_customers
  
  context '#apply_customer_discounts' do
    
    it ' should assign the orders customer' do
      shop_orders(:several_items).discountables.should have(1).discountables
      shop_orders(:several_items).apply_customer_discounts
      shop_orders(:several_items).discountables.should have(2).discountables
    end

  end

  context '.find_by_session' do
    
    it 'should now call #apply_customer_discounts on the returned object' do
      @order = shop_orders(:several_items)
      mock(@order).apply_customer_discounts { true }
      mock(ShopOrder).find(@order.id) { @order }
      
      ShopOrder.find_by_session(@order.id)
    end
    
    it 'should return ActiveRecord::RecordNotFound if the order does not exist' do
      expect{ ShopOrder.find_by_session(1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
    
  end

  context 'packaged discounts' do
    let!(:bread_box_discount) { shop_discounts(:bread_box_discount) }

    context 'cart is empty' do
      let(:cart) { shop_orders(:empty) }

      it '#possible_discounts returns []' do
        cart.possible_discounts.should_not include bread_box_discount
      end

      it '#possible_discounts? returns false' do
        cart.possible_discounts?.should be_false
      end

      context 'multiple items are added' do
        let!(:crusty_bread) { cart.line_items.create :item => shop_products(:crusty_bread), :quantity => 2, :item_price => 13 }
        let!(:soft_bread) { cart.line_items.create :item => shop_products(:soft_bread), :quantity => 2, :item_price => 19 }

        it 'includes a line item describing the discount' do
          cart.line_items.should be_any { |line_item| line_item.item.is_a?(ShopDiscount) }
        end

        it 'the line item is not purchaseable' do
          line_item = cart.line_items.detect { |line_item| line_item.item.is_a?(ShopDiscount) }
          line_item.purchaseable.should be_false
        end

        it 'the discount has a quantity of 2' do
          cart.line_items.detect { |line_item| line_item.item.is_a?(ShopDiscount) }.quantity.should == 2
        end

        context 'one item is removed' do
          before do
            crusty_bread.update_attributes(:quantity => 1)
          end

          it 'the discount has a quantity of 1' do
            cart.line_items.detect { |line_item| line_item.item.is_a?(ShopDiscount) }.quantity.should == 1
          end
        end
      end

      context 'when crusty bread is added' do
        let!(:crusty_bread) { cart.line_items.create :item => shop_products(:crusty_bread), :quantity => 1, :item_price => 13 }

        it '#possible_discounts includes the bread box discount' do
          cart.possible_discounts.should include bread_box_discount
        end

        it 'returns soft bread when asked what product is missing for the bread box discount' do
          cart.missing_products_for_discount(bread_box_discount).should include shop_products(:soft_bread)
        end

        it 'returns crusty bread when asked what product is in the bread box discount' do
          cart.products_in_discount(bread_box_discount).should include shop_products(:crusty_bread)
        end

        it '#possible_discounts? returns true' do
          cart.possible_discounts?.should be_true
        end

        it 'does not include a line item describing the discount' do
          cart.line_items.should_not be_any { |line_item| line_item.item.is_a?(ShopDiscount) }
        end

        context 'and soft bread is added' do
          let!(:soft_bread) { cart.line_items.create :item => shop_products(:soft_bread), :quantity => 1, :item_price => 19 }

          it '#possible_discounts is empty' do
            cart.possible_discounts.should be_empty
          end

          it 'includes a line item describing the discount' do
            cart.line_items.should be_any { |line_item| line_item.item.is_a?(ShopDiscount) }
          end

          it 'the line item is not purchaseable' do
            line_item = cart.line_items.detect { |line_item| line_item.item.is_a?(ShopDiscount) }
            line_item.purchaseable.should be_false
          end

          context 'and crusty bread is removed' do
            before do
              cart.line_items.destroy(crusty_bread)
            end

            it '#possible_discounts includes the bread box discount' do
              cart.possible_discounts.should include bread_box_discount
            end

            it 'does not include a line item describing the discount' do
              cart.line_items.should_not be_any { |line_item| line_item.item.is_a?(ShopDiscount) }
            end

            it 'returns crusty bread when asked what product is missing for the bread box discount' do
              cart.missing_products_for_discount(bread_box_discount).should include shop_products(:crusty_bread)
            end

            it 'returns soft bread when asked what product is in the bread box discount' do
              cart.products_in_discount(bread_box_discount).should include shop_products(:soft_bread)
            end

            it '#possible_discounts? returns true' do
              cart.possible_discounts?.should be_true
            end
          end
        end
      end
    end
  end
  
end
