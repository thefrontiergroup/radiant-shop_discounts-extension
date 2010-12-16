require File.dirname(__FILE__) + "/../../../spec_helper"

describe ApplicationController do
  
  dataset :users, :shop_discounts
  
  before(:each) do
    login_as  :admin
  end
  
  it 'needs supporting specs'
  
end