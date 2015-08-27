Sequel.migration do
  change do
    create_table(:messages) do
      uuid :id
      primary_key [:id]
      File :data, null: false
    end
  end
end
