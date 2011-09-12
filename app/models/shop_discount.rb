class ShopDiscount < ActiveRecord::Base

  # Return all discounts which are valid
  default_scope :conditions => [
    '(starts_at IS NULL and finishes_at IS NULL) OR (starts_at >= :now AND finishes_at <= :now) OR (starts_at IS NULL and finishes_at <= :now)', 
    { :now => Time.now }
  ]
  
  belongs_to  :created_by,  :class_name => 'User'
  belongs_to  :updated_by,  :class_name => 'User'
  
  has_many    :discountables,            :class_name => 'ShopDiscountable',         :foreign_key  => :discount_id
  
  has_many    :products,    :through => :discountables, :source => :product,  :conditions => "shop_discountables.discounted_type = 'ShopProduct'"
  has_many    :users,       :through => :discountables, :source => :user,     :conditions => "shop_discountables.discounted_type = 'User'"
  has_many    :line_items,  :through => :discountables, :source => :line_item,:conditions => "shop_discountables.discounted_type = 'ShopLineItem'"
  
  has_many    :discountables_categories, :class_name => 'ShopDiscountableCategory', :foreign_key  => :discount_id
  has_many    :categories,  :through => :discountables_categories, :source => :category, :conditions => "shop_discountables.discounted_type = 'ShopCategory'"
  
  has_many    :discountables_orders,      :class_name => 'ShopDiscountableOrder',    :foreign_key  => :discount_id
  has_many    :orders,      :through => :discountables_orders, :source => :order, :conditions => "shop_discountables.discounted_type = 'ShopOrder'"

  
  validates_presence_of     :name, :amount
  validates_uniqueness_of   :name
  validates_uniqueness_of   :code, :allow_blank => true
  validates_numericality_of :amount
  
  # This will override the default scope
  def self.all_including_invalid(*attrs)
    with_exclusive_scope{find(:all,*attrs)}
  end
  
  # Return all categories minus its own
  def available_categories
    ShopCategory.all - categories
  end
  
  # Returns all products minus its own
  def available_products
    ShopProduct.all - products
  end
  
  def available_users
    User.all - users
  end
  
end
