module ShopDiscounts
  module Models
    module DiscountCodes

      def self.included(base)
        base.class_eval do

          # TODO: Will need to have a discount code
          # database field, temporarily using an accessor
          attr_accessor :discount_code
        end
      end

    end
  end
end
