require 'spec/spec_helper'

#
# Test for ShopDiscounts Item Tag Extensions
#
describe ShopDiscounts::Tags::Item do

  dataset :pages, :shop_orders, :shop_line_items, :shop_discounts, :shop_discountables

  it 'should describe these tags' do
    ShopDiscounts::Tags::Item.tags.sort.should =~ [
      'shop:cart:item:value',
      'shop:cart:item:discount',
      'shop:cart:item:discounted',
      'shop:cart:item:rrp',
      'shop:cart:item:if_discounted',
      'shop:cart:item:if_discounted_with_code',
      'shop:cart:item:unless_discounted_with_code',
      'shop:cart:item:discount_code',
      'shop:cart:item:unless_discounted'].sort
  end

  context 'page tags' do

    before :all do
      @page = pages(:home)
    end

    before :each do
      @line_item = shop_line_items(:one)
      shop_discounts(:ten_percent).discountables.create(:discounted => @line_item)
      stub(Shop::Tags::Helpers).current_line_item(anything) { @line_item }
    end

    describe '<r:shop:cart:item:value />' do
      it 'should return the value of the item' do
        tag = %{<r:shop:cart:item:value />}
        exp = Shop::Tags::Helpers.currency(@line_item.value)

        @page.should render(tag).as(exp)
      end
    end

    describe '<r:shop:cart:item:discount />' do
      it 'should return the markdown of the item' do
        tag = %{<r:shop:cart:item:discount />}
        exp = Shop::Tags::Helpers.currency(@line_item.discount)

        @page.should render(tag).as(exp)
      end
    end

    describe '<r:shop:cart:item:if_discounted />' do
      context 'item is discounted' do
        it 'should expand' do
          tag = %{<r:shop:cart:item:if_discounted>success</r:shop:cart:item:if_discounted>}
          exp = %{success}

          @page.should render(tag).as(exp)
        end
      end

      context 'item is not discounted' do
        before :each do
          @line_item.discounts.delete_all
        end
        it 'should not expand' do
          tag = %{<r:shop:cart:item:if_discounted>failure</r:shop:cart:item:if_discounted>}
          exp = %{}

          @page.should render(tag).as(exp)
        end
      end
    end

    describe '<r:shop:cart:item:if_discounted_with_code />' do
      context 'item is discounted but not with a code' do

        it 'should not expand' do
          tag = %{<r:shop:cart:item:if_discounted_with_code>failure</r:shop:cart:item:if_discounted_with_code>}
          exp = %{}

          @page.should render(tag).as(exp)
        end

      end

      context 'item is discounted with a code' do

        before :each do
          code = @line_item.discounts.first.code
          @line_item.update_attributes(:discount_code => code)
        end

        it 'should expand' do
          tag = %{<r:shop:cart:item:if_discounted_with_code>success</r:shop:cart:item:if_discounted_with_code>}
          exp = %{success}

          @page.should render(tag).as(exp)
        end

      end

      context 'item is not discounted' do
        before :each do
          @line_item.discounts.delete_all
        end

        it 'should not expand' do
          tag = %{<r:shop:cart:item:if_discounted_with_code>failure</r:shop:cart:item:if_discounted_with_code>}
          exp = %{}

          @page.should render(tag).as(exp)
        end

      end

    end

    describe '<r:shop:cart:item:unless_discounted_with_code />' do
      context 'item is discounted but not with a code' do

        it 'should expand' do
          tag = %{<r:shop:cart:item:unless_discounted_with_code>success</r:shop:cart:item:unless_discounted_with_code>}
          exp = %{success}

          @page.should render(tag).as(exp)
        end

      end

      context 'item is discounted with a code' do

        before :each do
          code = @line_item.discounts.first.code
          @line_item.update_attributes(:discount_code => code)
        end

        it 'should not expand' do
          tag = %{<r:shop:cart:item:unless_discounted_with_code>failure</r:shop:cart:item:unless_discounted_with_code>}
          exp = %{}

          @page.should render(tag).as(exp)
        end

      end

      context 'item is not discounted' do
        before :each do
          @line_item.discounts.delete_all
        end

        it 'should expand' do
          tag = %{<r:shop:cart:item:unless_discounted_with_code>success</r:shop:cart:item:unless_discounted_with_code>}
          exp = %{success}

          @page.should render(tag).as(exp)
        end

      end

    end

    describe '<r:shop:cart:item:unless_discounted />' do
      context 'item is not discounted' do
        before :each do
          @line_item.discounts.delete_all
        end
        it 'should expand' do
          tag = %{<r:shop:cart:item:unless_discounted>success</r:shop:cart:item:unless_discounted>}
          exp = %{success}

          @page.should render(tag).as(exp)
        end
      end

      context 'item is discounted' do
        it 'should not expand' do
          tag = %{<r:shop:cart:item:unless_discounted>failure</r:shop:cart:item:unless_discounted>}
          exp = %{}

          @page.should render(tag).as(exp)
        end
      end
    end

    describe '<r:shop:cart:item:discount_code' do
      it 'should return the discount code for the product' do

        @line_item.discount_code = 'FGHZ'
        @line_item.save

        tag = %{<r:shop:cart:item:discount_code />}
        exp = 'FGHZ'

        @page.should render(tag).as(exp)

      end
    end

  end

end
