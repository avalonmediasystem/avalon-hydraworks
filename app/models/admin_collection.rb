
require 'hydra/datastream/non_indexed_rights_metadata'
# require 'hydra/model_mixins/hybrid_delegator'
# require 'role_controls'
# require 'avalon/controlled_vocabulary'
# require 'avalon/sanitizer'

class AdminCollection < ActiveFedora::Base
  include Hydra::Works::CollectionBehavior
  # include Hydra::AccessControls::Permissions
  # include Hydra::ModelMixins::HybridDelegator
  # include ActiveFedora::Associations
  # include VersionableModel

  has_many :media_objects, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isMemberOfCollection
  contains 'descMetadata', class_name: 'ActiveFedora::SimpleDatastream' do |sds|
    sds.field :name, :string
    sds.field :unit, :string
    sds.field :description, :string
    sds.field :dropbox_directory_name
  end
  contains 'inheritedRights', class_name: 'Hydra::Datastream::InheritableRightsMetadata'
  contains 'defaultRights', class_name: 'Hydra::Datastream::NonIndexedRightsMetadata', autocreate: true

  property :name, delegate_to: :descMetadata, multiple: false
  property :unit, delegate_to: :descMetadata, multiple: false
  property :description, delegate_to: :descMetadata, multiple: false
  property :dropbox_directory_name, delegate_to: :descMetadata, multiple: false
end
