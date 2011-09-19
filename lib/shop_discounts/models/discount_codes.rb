module ShopDiscounts
  module Models
    module DiscountCodes

      def self.included(base)
        base.class_eval do

          before_save :add_discount_code if :discount_code_changed?

        end
      end

      def add_discount_code
        if discounts.blank?
          discount = ShopDiscount.find(:first, :conditions => { :code => discount_code })
          if discount.present?
            discounts << discount
          end
        end
      end

    end
  end
end
