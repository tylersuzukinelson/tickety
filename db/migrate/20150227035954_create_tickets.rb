class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      # t.references :user, index: true
      t.string :title
      t.text :body
      t.integer :resolved_by

      t.timestamps null: false
    end
    # add_foreign_key :tickets, :users
  end
end
