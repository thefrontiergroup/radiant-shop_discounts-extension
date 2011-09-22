module ShopDiscounts
  module Models
    module Purchaseable

      def self.included(base)
        base.class_eval do

          def per_item_discount
            discounts.regular_discounts.inject('0'.to_d) do |total, discount|
              case discount.amount_type
              when 'currency' then discount.amount
              else discount.amount / '100'.to_d * item_price
              end + total
            end
          end

          def total_discount
            per_item_discount * quantity
          end

          def discounted_price
            item_price - per_item_discount
          end

          def discounted?
            per_item_discount > 0
          end

          alias_method :rrp, :cost
          def cost
            cost = discounted_price * quantity
            cost -= tax if Radiant::Config['shop.tax_strategy'] === 'exclusive'
            cost
          end

          def tax
            percentage = Radiant::Config['shop.tax_percentage'].to_d / '100'.to_d

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
            rrp - total_discount
          end
        end
      end

    end
  end
end
