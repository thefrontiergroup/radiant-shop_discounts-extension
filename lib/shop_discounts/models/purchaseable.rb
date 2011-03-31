module ShopDiscounts
  module Models
    module Purchaseable

      def self.included(base)
        base.class_eval do

          def discount
            discount = BigDecimal.new('0.00')
            discounts.map { |d| discount += d.amount }

            # Maximum discount is 100%
            discount = [discount,BigDecimal.new('100.0')].min

            # Convert to a percentage
            discount * BigDecimal.new('0.01')
          end

          def discounted
            (rrp * discount)
          end

          alias_method :rrp, :cost
          def cost
            cost = (item_price * quantity) - ((item_price * quantity) *discount)
            cost -= tax if Radiant::Config['shop.tax_strategy'] === 'exclusive'
            cost
          end

          def tax
            percentage = Radiant::Config['shop.tax_percentage'].to_f * 0.01

            case Radiant::Config['shop.tax_strategy']
            when 'inclusive'
              tax = price - (price / (1 + percentage))
            when 'exclusive'
              tax = price * percentage
            else
              tax = 0
            end

            BigDecimal.new(tax.to_s)
          end

          def price
            rrp - discounted
          end
        end
      end

    end
  end
end
