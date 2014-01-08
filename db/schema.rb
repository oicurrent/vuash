ActiveRecord::Schema.define(:version => 0) do
  create_table :messages do |t|
    t.binary :data
    t.string :uuid
  end
end
