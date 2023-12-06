class CreateConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :configurations do |t|
      t.text :about_text
      t.string :contact_phone
      t.string :contact_email

      t.timestamps
    end
  end
end
