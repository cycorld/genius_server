class CreateMsgs < ActiveRecord::Migration
  def change
    create_table :msgs do |t|
      t.integer     :send_id,   :null => false
      t.integer     :recv_id,   :null => false
      t.string      :content
      t.boolean     :deleted,   :default => false
      t.boolean     :command,   :default => false

      t.timestamps
    end
  end
end
