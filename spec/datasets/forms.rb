class FormsDataset < Dataset::Base
  
  uses :pages, :shop_discounts

  def mock_valid_form_discount_request
    @form = forms(:checkout)
    @form[:extensions] = {
      :discount => {
        :process => 'add'
      }
    }
    @data = {
     :discount => {
       :code => shop_discounts(:ten_percent).code
     } 
    }

    @request.session = { :shop_order => @order.id }
  end
  
end