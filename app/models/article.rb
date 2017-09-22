class Article < ActiveRecord::Base
 	has_many :article_tags
 	has_many :tags, through: :article_tags
 	belongs_to :category
 	belongs_to :source
 	has_many :article_authors
 	has_many :authors, through: :article_authors




end
