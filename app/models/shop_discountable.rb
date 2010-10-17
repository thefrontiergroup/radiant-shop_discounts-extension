class ShopDiscountable < ActiveRecord::Base
  
  belongs_to :discount,   :class_name => 'ShopDiscount',  :foreign_key => :discount_id
  belongs_to :discounted, :foreign_key => :discounted_id, :polymorphic => true
  belongs_to :category,   :class_name => 'ShopCategory',  :foreign_key => :discounted_id
  belongs_to :product,    :class_name => 'ShopProduct',   :foreign_key => :discounted_id
  belongs_to :order,      :class_name => 'ShopOrder',     :foreign_key => :discounted_id
  belongs_to :line_item,  :class_name => 'ShopLineItem',  :foreign_key => :discounted_id
  
  validates_presence_of   :discount, :discounted
  validates_uniqueness_of :discounted_id, :scope => [ :discount_id, :discounted_type ]
  
  before_validation       :create_shop_products_if_shop_category
  before_destroy          :destroy_shop_products_if_shop_category
  
  before_validation       :create_shop_line_items_if_shop_order
  before_destroy          :destroy_shop_line_items_if_shop_order
  
  # Returns discount of a class
  def self.for(type)
    all(:conditions => { :discounted_type => type.pluralize.classify })
  end
  
  # Adds discount to a category's products
  def create_shop_products_if_shop_category
    if discounted_type === 'ShopCategory'
      discounted.products.each do |product|
        # Attach discount to the child product
        ShopDiscountable.create(:discount => discount, :discounted => product)
      end
    end
  end
  
  # Removes discount from a category's products
  def destroy_shop_products_if_shop_category
    if discounted_type === 'ShopCategory'
      discount.discountables.for('ShopProduct').each do |discountable|
        discountable.destroy
      end
    end
  end
  
  # Adds discount to an order's line_items
  def create_shop_line_items_if_shop_order
    if discounted_type === 'ShopOrder'
      discounted.line_items.each do |line_item|
        if line_item.item.discounts.include?(discount)
          # We're here if the item associated with the line item can be discounted
          discount = ShopDiscountable.create(:discount_id => discount_id, :discounted => line_item)
        end
      end
    end
  end
  
  # Removes discount from an order's line_items
  def destroy_shop_line_items_if_shop_order
    if discounted_type === 'ShopOrder'
      discount.discountables.for('ShopLineItem').each do |discountable|
        discountable.destroy
      end
    end
  end
  
end