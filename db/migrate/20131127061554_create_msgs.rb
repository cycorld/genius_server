class CreateMsgs < ActiveRecord::Migration
  def change
    create_table :msgs do |t|

      t.timestamps
    end
  end
end
