require 'acts_as_localizable'
require 'rails'

module ActsAsLocalizable
  class Engine < Rails::Engine
    initializer "acts_as_localizable.init" do |app|
      ActiveRecord::Base.class_eval do
        include ActsAsLocalizable::AR
      end
      
    end
  end
  
  
end

