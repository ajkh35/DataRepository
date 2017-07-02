class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :title
      t.attachment :doc

      t.timestamps
    end
  end
end
