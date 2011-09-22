class ShopLineItemObserver < ActiveRecord::Observer

  # If the quantity of a line item has changed for an order, the package discounts have to be altered also
  def after_save(line_item)
    return if line_item.order.nil?
    RAILS_DEFAULT_LOGGER.info "debug: Line item saved #{line_item.inspect}"
    line_item.order.update_package_discounts(line_item)
  end

end
