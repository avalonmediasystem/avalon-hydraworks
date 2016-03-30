
require 'hydra/datastream/non_indexed_rights_metadata'
require 'hydra/model_mixins/hybrid_delegator'
require 'role_controls'
require 'avalon/controlled_vocabulary'
require 'avalon/sanitizer'

class Admin::Collection < Hydra::Works::Collection
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

  has_attributes :name, datastream: :descMetadata, multiple: false
  has_attributes :unit, datastream: :descMetadata, multiple: false
  has_attributes :description, datastream: :descMetadata, multiple: false
  has_attributes :dropbox_directory_name, datastream: :descMetadata, multiple: false
end
