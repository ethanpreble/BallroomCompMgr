class CreatePartnerships < ActiveRecord::Migration
  def change
    create_table :partnerships do |t|
      t.belongs_to :lead, class_name: 'User', null: false, index: true
      t.belongs_to :follow, class_name: 'User', null: false, index: true
      t.timestamps null: false
    end
    add_index :partnerships, [:lead_id, :follow_id], :unique => true
  end
end
