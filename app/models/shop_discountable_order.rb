class ShopDiscountableOrder < ShopDiscountable
    
  before_validation       :create_shop_line_items
  before_destroy          :destroy_shop_line_items
  
  belongs_to :order,      :class_name => 'ShopOrder',     :foreign_key => :discounted_id
  
  # Adds discount to an order's line_items
  def create_shop_line_items
    discounted.line_items.each do |line_item|
      if line_item.item.discounts.include?(discount)
        # We're here if the item associated with the line item can be discounted
        discount = ShopDiscountable.create(:discount_id => discount_id, :discounted => line_item)
      end
    end
  end
  
  # Removes discount from an order's line_items
  def destroy_shop_line_items
    discounted.discountables.for('ShopLineItem').each do |discountable|
      discountable.destroy
    end
  end
  
end