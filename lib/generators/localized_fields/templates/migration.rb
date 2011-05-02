class CreateLocalizedFields < ActiveRecord::Migration
  def self.up
    create_table :localized_fields do |t|
      t.string :localized_object_type
      t.integer :localized_object_id
      t.string :locale
      t.string :field_name
      t.text :value
      #Any additional fields here

      t.timestamps
    end
    add_index :localized_fields,[:localized_object_type,:localized_object_id], :name => 'index_localized_fields_on_object_type_and_id'
  end

  def self.down
    drop_table :localized_fields
  end
end
