Sequel.migration do
  change do
    create_table :user_sessions do
      uuid :id, primary_key: true
      foreign_key :user_id, :users, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end