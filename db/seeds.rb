# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'httparty'
require 'json'

API_KEY = "2fff809c9ae4404e80c9be138d3f7d0f"

source_request = HTTParty.get("https://newsapi.org/v1/sources?language=en", format: :plain)
source_JSON = JSON.parse(source_request)
sources = source_JSON["sources"]


sources.each do |source|
	category = Category.find_or_create_by(name: source["category"])
	source_articles = JSON.parse(HTTParty.get("https://newsapi.org/v1/articles?source=" + source["id"] + "&apiKey=" + API_KEY, format: :plain))["articles"]
	source_articles.each do |article|
		
		new_article = Article.create(title: article["title"], summary: article["description"], article_url: article["url"], category_id: category.id, image_url: article["urlToImage"], date: article["publishedAt"] )
		if article["author"]
			article["author"].split(", ").each do |author_name|
				new_author = Author.find_or_create_by(name: author_name)
				ArticleAuthor.create(article_id: new_article.id, author_id: new_author.id)
			end 
		else 
			null_author = Author.find_or_create_by(name: "")
			ArticleAuthor.create(article_id: new_article.id, author_id: null_author.id)
		end 
    end
end


