unless defined? RADIANT_ROOT
  ENV["RAILS_ENV"] = "test"
  case
  when ENV["RADIANT_ENV_FILE"]
    require ENV["RADIANT_ENV_FILE"]
  when File.dirname(__FILE__) =~ %r{vendor/radiant/vendor/extensions}
    require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../../../")}/config/environment"
  else
    require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../")}/config/environment"
  end
end
require "#{RADIANT_ROOT}/spec/spec_helper"

require ShopExtension.root + '/spec/spec_helper'

unless defined? SHOP_DISCOUNTS_ROOT
  
  SHOP_DISCOUNTS_ROOT = ShopDiscountsExtension.root + '/spec'
  
  Dataset::Resolver.default << (SHOP_DISCOUNTS_ROOT + "/datasets")
  
  Dir[SHOP_ROOT + "/matchers/*.rb"].each {|file| require file }
  if File.directory?(SHOP_DISCOUNTS_ROOT + "/matchers")
    Dir[SHOP_DISCOUNTS_ROOT + "/matchers/**/*.rb"].each {|file| require file }
  end
  
  Spec::Runner.configure do |config|
    config.mock_with :rr
  end
  
end