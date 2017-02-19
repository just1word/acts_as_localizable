require 'acts_as_localizable/engine' if defined?(Rails)

module ActsAsLocalizable::AR
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  class Config
    attr_reader :default_locale
    attr_reader :model_id
    def initialize(model_id,default_locale)
      @model_id = model_id
      @default_locale = default_locale.to_s.downcase
    end
  end
  class LocalValues
    def initialize(locale,default_values)
      self.instance_variable_set("@locale",locale)
      self.instance_variable_set("@modified",false)
      self.instance_variable_set("@modified_attributes",[])
      default_values.each_pair do |key,value|
        
        self.instance_variable_set("@#{key}",value)
        self.class_eval("attr_reader :#{key}")
       
        self.class_eval("def #{key}=(value)
          @modified = true
          @modified_attributes << '#{key}'
          instance_variable_set('@#{key}',value)
        end")
      end
    end
  
    def modified?
      return self.instance_variable_get("@modified")
    end
    def modified_attributes
      return self.instance_variable_get("@modified_attributes")
    end
    def locale
      return self.instance_variable_get("@locale")
    end
  end
  
  module ClassMethods
    def acts_as_localizable(default_locale=nil)
      if default_locale == nil
        default_locale = I18n.default_locale
      end
      model_id = self.to_s.split('::').last.pluralize.singularize.underscore
      default_locale = 'en' unless default_locale
      @acts_as_localizable_config = ActsAsLocalizable::AR::Config.new(model_id,default_locale)
      #self.superclass.class_eval do
      #  has_many :localized_fields, :as => :localized_object,:dependent => :destroy
      #end      
      self.class_eval do
        has_many :localized_fields, :as => :localized_object,:dependent => :destroy
        default_scope { :include => [:localized_fields] }
        attr_accessor :localized_cache
        after_save :save_localized_attributes
        private
        
        def save_localized_attributes
          return if self.localized_cache.blank?
          self.localized_cache.each_pair do |key,locale_object|
            locale_object.modified_attributes.each do  |modified_field|
              fields = self.localized_fields.select {|localized_field| localized_field.locale.downcase == key.to_s.downcase && localized_field.field_name == modified_field}
              if fields.blank?
                field = self.localized_fields.new(:locale => key.to_s.downcase,:field_name => modified_field,:value => locale_object.instance_variable_get("@#{modified_field}"))
                field.save
              else
                field = fields.first
                field.value = locale_object.instance_variable_get("@#{modified_field}")
                field.save
              end
            end
            
          end
        end
      end
      # self.superclass.send(:default_scope){{:include => [:localized_fields]}}
       # self.superclass.default_scoping << {:include => [:localized_fields]}
      include ActsAsLocalizable::AR::InstanceMethods
    end
    def acts_as_localizable_config
      @acts_as_localizable_config || self.superclass.instance_variable_get('@acts_as_localizable_config')
    end

  end
  
  module InstanceMethods
      # has_many :localized_fields,:as => :object

    def localized(locale=nil)
      if locale == nil
        locale = I18n.locale
      end
      default_values = self.attributes
      if self.class.acts_as_localizable_config.default_locale.downcase != locale.to_s.downcase && (self.localized_cache.blank? == true || self.localized_cache[locale].blank? == true)
        fields = self.localized_fields.select {|localized_field| localized_field.locale.downcase == locale.to_s.downcase}
        
        if fields.blank? == false
          fields.each do |field|
            default_values[field.field_name] = field.value;
          end
        end
      end
      if self.localized_cache == nil
        self.localized_cache = {locale => ActsAsLocalizable::AR::LocalValues.new(locale,default_values)}
      elsif self.localized_cache[locale].blank?
        self.localized_cache[locale] = ActsAsLocalizable::AR::LocalValues.new(locale,default_values)
      end
      return self.localized_cache[locale]
    end
    


  end
end
