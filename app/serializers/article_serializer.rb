class ArticleSerializer < ActiveModel::Serializer
  attributes :title, :summary, :content, :article_url, :image_url, :date

  belongs_to :category
  belongs_to :source
end
