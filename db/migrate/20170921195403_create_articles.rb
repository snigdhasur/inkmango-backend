class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
    	t.string :title
    	t.string :summary
   		t.integer :category_id
    	t.text :content
    	t.string :article_url
    	t.string :image_url
    	t.datetime :date

    	t.timestamps
    end
  end
end
