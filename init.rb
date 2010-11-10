# Include hook code here
ActiveRecord::Base.class_eval do
  include ActsAsLocalizable
end
