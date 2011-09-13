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

          def line_item_added(line_item)
            create_applicable_package_discounts(line_item)
          end

          def line_item_removed(line_item)
            remove_ineligible_package_discounts(line_item)
          end

          # Get a list of discounts this shopping cart might be eligible for if
          # some more products are added
          def possible_discounts
            discounts = Set.new
            line_items.each do |line_item|
              line_item.item.discounts.package_discounts.each do |discount|
                unless has_all_products_for_discount?(discount)
                  discounts << discount
                end
              end
            end
            discounts
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

          # TODO: These could use some optimization but are correct for now
          def create_applicable_package_discounts(line_item_added)
            applicable_discounts(line_item_added).each do |discount|
              discount.products.each do |product|
                line_items.find_by_item_id(product.id).discountables.create(:discount => discount)
              end
            end
          end

          def remove_ineligible_package_discounts(line_item_removed)
            line_item_removed.item.discounts.each do |discount|
              unless has_all_products_for_discount?(discount)
                ShopDiscountable.delete_all [
                  "discount_id = ? AND discounted_id IN (?) AND discounted_type = ?",
                  discount.id,
                  line_items.map(&:id),
                  line_item_removed.class.to_s]
              end
            end
          end

          def applicable_discounts(line_item)
            applicable_discounts = Set.new
            line_item.item.discounts.package_discounts.each do |discount|
              if has_all_products_for_discount?(discount)
                applicable_discounts << discount
              end
            end
            applicable_discounts
          end

          def has_all_products_for_discount?(discount)
            discount.products.all? do |product|
              line_items.exists?(:item_id => product.id)
            end
          end
        end
      end
      
    end
  end
end
