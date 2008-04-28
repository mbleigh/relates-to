ActiveRecord::Schema.define :version => 0 do
  create_table :relatable_users, :force => true do |t|
    t.column :name, :string
  end
  
  create_table :relatable_forums, :force => true do |t|
    t.column :name, :string
  end
  
  create_table :relatable_photos, :force => true do |t|
    t.column :name, :string
  end
  
  create_table :relationships, :force => true do |t|
    t.column :relator_type, :string
    t.column :relator_id, :integer
    t.column :related_type, :string
    t.column :related_id, :integer
    t.column :nature, :string
    t.column :created_at, :datetime
    t.column :updated_at, :datetime
  end
end
