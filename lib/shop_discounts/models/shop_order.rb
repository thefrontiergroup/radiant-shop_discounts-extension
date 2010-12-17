module ShopDiscounts
  module Models
    module ShopOrder
      
      def self.included(base)
        base.class_eval do
                    
          # Assigns discounts based off the customers discounts
          def apply_customer_discounts
            customer.discounts.each do |discount|
              ShopDiscountable.create(:discount_id => discount.id, :discounted_id => self.id, :discounted_type => self.class.name)
            end
          end
          
          class << self
            alias_method :original_find_by_session, :find_by_session
            def find_by_session(session)
              if order = original_find_by_session(session)
                order.apply_customer_discounts
              end
            end
          end
        end
      end
      
    end
  end
end