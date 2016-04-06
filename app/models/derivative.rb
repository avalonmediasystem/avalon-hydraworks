# require 'hydra/datastream/non_indexed_rights_metadata'
# require 'hydra/model_mixins/hybrid_delegator'
# require 'role_controls'
# require 'avalon/controlled_vocabulary'
# require 'avalon/sanitizer'

class Derivative < ActiveFedora::Base
  # include Hydra::Works::CollectionBehavior
  # include ActiveFedora::Associations
  # include VersionableModel

  # belongs_to :masterfile, :class_name=>'MasterFile', :property=>:is_derivation_of

  # has_model_version 'R6'

# These fields do not fit neatly into the Dublin Core so until a long
# term solution is found they are stored in a simple datastream in a
# relatively flat structure.
#
# The only meaningful value at the moment is the url, which points to
# the stream location. The other two are just stored until a migration
# strategy is required.

  contains 'descMetadata', class_name: 'ActiveFedora::SimpleDatastream' do |d|
    d.field :location_url, :string
    d.field :hls_url, :string
    d.field :duration, :string
    d.field :track_id, :string
    d.field :hls_track_id, :string
  end

  contains 'derivativeFile', class_name: 'UrlDatastream'

# property :dropbox_directory_name, delegate_to: :descMetadata, multiple: false do |index|
#   index.as :facetable, type: :string
# end
  property :location_url, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :hls_url, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :duration, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :track_id, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :hls_track_id, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  # datastream: :descMetadata,
  # multiple: false

  contains 'encoding', class_name: 'EncodingProfileDocument'
end
