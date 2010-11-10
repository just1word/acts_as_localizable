class LocalizedField < ActiveRecord::Base
  belongs_to :localized_object,:polymorphic => true
end