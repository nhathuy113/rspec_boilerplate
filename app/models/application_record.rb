class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
  #
  # settings index: { number_of_shards: 1 } do
  #   mappings dynamic: 'false' do
  #     indexes :title, analyzer: 'english'
  #     indexes :content, analyzer: 'english'
  #   end
  # end
end
