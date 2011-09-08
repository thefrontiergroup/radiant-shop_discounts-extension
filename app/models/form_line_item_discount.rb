class FormLineItemDiscount
  include Forms::Models::Extension
  include Shop::Models::FormExtension
  
  def create
    result ||= { process.to_sym => false }
    
    find_current_order

    return result unless process == 'modify'

    line_items.each do |id, line_item_attributes|
      line_item = ShopLineItem.find(id)
      if discount = (line_item_attributes[:discount_code].presence && ShopDiscount.find_by_code_and_product_id(line_item_attributes[:discount_code], line_item.product_id))
        discountable = discount.discountables.create(:discounted_id => line_item.id, :discounted_type => line_item.class.name)
        result[process.to_sym] = discountable.valid?
      end
    end

    result
  end

  def process
    @config[:process]
  end

  def line_items
    @data[:line_items]
  end

end
