class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :number
      t.binary :data

      t.timestamps
    end
  end
end
