require 'spec_helper'

describe ShopDiscounts::Tags::PossibleDiscounts do

  dataset :pages, :shop_orders, :shop_line_items, :shop_discounts, :shop_discountables

  before :all do
    @page = pages(:home)
  end

  it 'should describe the possible discount tags' do
    ShopDiscounts::Tags::Item.tags.should include [
      'shop:cart:if_possible_discount',
      'shop:cart:unless_possible_discount',
      'shop:cart:possible_discounts',
      'shop:cart:possible_discounts:each',
      'shop:cart:possible_discounts:each:name',
      'shop:cart:possible_discounts:each:amount',
      'shop:cart:possible_discounts:each:products:each',
      'shop:cart:possible_discounts:each:products:each:product']
  end

  context 'package discounts' do
    let(:cart) { shop_orders(:empty) }
    let!(:bread_box_discount) { shop_discounts(:bread_box_discount) }

    before do
      mock(Shop::Tags::Helpers).current_order(anything) { cart }
    end

    context 'when the current shopping cart does not have any possible discounts' do
      describe 'shop:cart:if_possible_discount' do
        it 'should not expand the tag' do
          tag = %{<r:shop:cart:if_possible_discount>success</r:shop:cart:if_possible_discount>}
          exp = %{}

          @page.should render(tag).as(exp)
        end
      end

      describe 'shop:cart:unless_possible_discount' do
        it 'should not expand the tag' do
          tag = %{<r:shop:cart:unless_possible_discount>success</r:shop:cart:unless_possible_discount>}
          exp = %{success}

          @page.should render(tag).as(exp)
        end
      end

      describe 'shop:cart:possible_discounts:each' do
        it 'should not expand this tag' do
          tag = %{<r:shop:cart:possible_discounts:each>round and round</r:shop:cart:possible_discounts:each>}
          exp = %{}

          @page.should render(tag).as(exp)
        end
      end
    end

    context 'when the current shopping cart has possible discounts' do

      let!(:crusty_bread) { cart.line_items.create :item => shop_products(:crusty_bread), :quantity => 1, :item_price => 13 }

      describe 'shop:cart:if_possible_discount' do
        it 'expands the tag' do
          tag = %{<r:shop:cart:if_possible_discount>success</r:shop:cart:if_possible_discount>}
          exp = %{success}

          @page.should render(tag).as(exp)
        end
      end

      describe 'shop:cart:unless_possible_discount' do
        it 'expands the tag' do
          tag = %{<r:shop:cart:unless_possible_discount>success</r:shop:cart:unless_possible_discount>}
          exp = %{}

          @page.should render(tag).as(exp)
        end
      end

      describe 'shop:cart:possible_discounts:each' do
        it 'expands the tag' do
          tag = %{<r:shop:cart:possible_discounts:each>round and round</r:shop:cart:possible_discounts:each>}
          exp = %{round and round}

          @page.should render(tag).as(exp)
        end
      end

      describe 'shop:cart:possible_discounts:each:name' do
        it 'expands the tag' do
          tag = %{<r:shop:cart:possible_discounts:each><r:name/></r:shop:cart:possible_discounts:each>}
          exp = 'bread box discount'

          @page.should render(tag).as(exp)
        end
      end

      describe 'shop:cart:possible_discounts:each:amount' do
        it 'expands the tag' do
          tag = %{<r:shop:cart:possible_discounts:each><r:amount/></r:shop:cart:possible_discounts:each>}
          exp = '10.0%'

          @page.should render(tag).as(exp)
        end
      end

      describe 'shop:cart:possible_discounts:each:products:each' do
        it 'expands the tag' do
          tag = %{<r:shop:cart:possible_discounts:each><r:products:each>lollipop </r:products:each></r:shop:cart:possible_discounts:each>}

          # There are 2 products
          exp = 'lollipop lollipop '

          @page.should render(tag).as(exp)
        end

      end
    end

  end

end
