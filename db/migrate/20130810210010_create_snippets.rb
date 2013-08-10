class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :filename
      t.text :content
      t.string :language
      t.text :pygment

      t.timestamps
    end
  end
end
