module ShopDiscounts
  module Models
    module DiscountCodes

      def self.included(base)
        base.class_eval do
          before_save :add_discount_code if :discount_code_changed?
        end
      end

      def add_discount_code
        if discounts.blank? && discount_code.present?
          # discount = ShopDiscount.find(:first, :conditions => { :code => discount_code })
          discountable = item.discountables.find(:first, :joins => :discount, :conditions => { :shop_discounts => { :code => discount_code.downcase } })
          if discountable.present?
            discounts << discountable.discount
          end
        end
      end

    end
  end
end
