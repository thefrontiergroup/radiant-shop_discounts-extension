class ShopDiscountable < ActiveRecord::Base
  
  belongs_to :discount,   :class_name => 'ShopDiscount',  :foreign_key => :discount_id
  belongs_to :discounted, :foreign_key => :discounted_id, :polymorphic => true
  
  belongs_to :product,    :class_name => 'ShopProduct',   :foreign_key => :discounted_id
  belongs_to :line_item,  :class_name => 'ShopLineItem',  :foreign_key => :discounted_id
  belongs_to :user,       :class_name => 'User',          :foreign_key => :discounted_id
  
  validates_presence_of   :discount, :discounted
  validates_uniqueness_of :discounted_id, :scope => [ :discount_id, :discounted_type ]
  
  # Returns discount of a class
  def self.for(type)
    all(:conditions => { :discounted_type => type.pluralize.classify })
  end
  
end