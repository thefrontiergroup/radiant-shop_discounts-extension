class FormDiscount
  include Forms::Models::Extension
  include Shop::Models::FormExtension
  
  def create
    @result ||= { process.to_sym => false }
    
    find_current_order
    
    case process
    when 'add'
      if @discount = ShopDiscount.find_by_code(discount_code)
        @discountable = @discount.discountables.create(:discounted_id => @order.id, :discounted_type => @order.class.name)
        @result[process.to_sym] = @discountable.valid?
      end
    when 'remove'
      if @discountable = @order.discountables.find(discountable_id)
        @result[process.to_sym] = @discountable.destroy
      end
    end
    
    @result
  end
  
  protected
  
  def process
    @config[:process]
  end
  
  def discount_code
    @data[:discount][:code]
  end
  
  def discountable_id
    @data[:discountable][:id]
  end
  
end