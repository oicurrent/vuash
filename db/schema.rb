ActiveRecord::Schema.define(:version => 0) do
  create_table :messages do |t|
    t.text :data
    t.string :uuid
  end
end
