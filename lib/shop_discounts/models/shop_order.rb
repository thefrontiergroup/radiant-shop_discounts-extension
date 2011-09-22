module ShopDiscounts
  module Models
    module ShopOrder

      def self.included(base)
        base.class_eval do

          after_save :apply_customer_discounts, :if => :customer_id_changed?

          # Assigns discounts based off the customers discounts
          def apply_customer_discounts
            return if customer.nil?
            customer.discounts.each do |discount|
              discountables.create(:discount => discount)
            end
          end

          def update_package_discounts(line_item)
            return unless line_item.purchaseable?

            line_item.item.discounts.package_discounts.each do |discount|

              if has_all_products_for_discount?(discount)
                count_of_discounts = eligible_discount_count(discount)
                create_or_update_discount(discount, count_of_discounts)
              else
                remove_discount(discount)
              end

            end
          end

          def line_item_removed(line_item)
            remove_ineligible_package_discounts(line_item)
          end

          def possible_discounts?
            possible_discounts.any?
          end

          # Get a list of discounts this shopping cart might be eligible for if
          # some more products are added
          def possible_discounts
            discounts = Set.new
            line_items.each do |line_item|
              next unless line_item.purchaseable?

              line_item.item.discounts.package_discounts.each do |discount|
                discounts << discount unless has_all_products_for_discount?(discount)
              end
            end
            discounts
          end

          def products_in_discount(discount)
            line_items.map(&:item) & discount.products
          end

          def missing_products_for_discount(discount)
            discount.products - line_items.map(&:item)
          end

          class << self
            alias_method :original_find_by_session, :find_by_session
            def find_by_session(session)
              if order = original_find_by_session(session)
                order.apply_customer_discounts
              end
              order
            end
          end

        private

          def remove_ineligible_package_discounts(line_item_removed)
            line_item_removed.item.discounts.each do |discount|
              remove_discount(discount) unless has_all_products_for_discount?(discount)
            end
          end

          def remove_discount(discount)
            ShopLineItem.delete_all ["item_id = ? AND order_id = ?", discount.id, id]
          end

          def applicable_discounts(line_item)
            applicable_discounts = Set.new

            return applicable_discounts unless line_item.purchaseable?

            line_item.item.discounts.package_discounts.each do |discount|
              if has_all_products_for_discount?(discount)
                applicable_discounts << discount
              end
            end

            applicable_discounts
          end

          def create_or_update_discount(discount, quantity)
            if new_line_item = line_items.find_by_item_id(discount.id)
              new_line_item.update_attributes!(:quantity => quantity)
            else
              line_items.create!(:item => discount, :quantity => quantity)
            end
          end

          def eligible_discount_count(discount)
            product_ids = required_product_ids(discount)
            line_items.minimum(:quantity, :conditions => {:item_id => product_ids})
          end

          def has_all_products_for_discount?(discount)
            product_ids = required_product_ids(discount)
            line_items.count(:conditions => {:item_id => product_ids}) == product_ids.size
          end

          def required_product_ids(discount)
            discount.products.all(:select => 'shop_products.id').map(&:id)
          end
        end
      end

    end
  end
end
