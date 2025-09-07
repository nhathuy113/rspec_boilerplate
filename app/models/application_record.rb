class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  if ENV["ELASTICSEARCH_ENABLED"] == "true"
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
  end
end
