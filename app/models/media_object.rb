# Copyright 2011-2015, The Trustees of Indiana University and Northwestern
#   University.  Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
#   under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
#   CONDITIONS OF ANY KIND, either express or implied. See the License for the
#   specific language governing permissions and limitations under the License.
# ---  END LICENSE_HEADER BLOCK  ---


class MediaObject < ActiveFedora::Base
#   include Hydra::AccessControls::Permissions
#   include Avalon::AccessControls::Hidden
#   include Avalon::AccessControls::VirtualGroups
#   include ActiveFedora::Associations
#   include Avalon::Workflow::WorkflowModelMixin
#   include VersionableModel
#   include Permalink
#   require 'avalon/controlled_vocabulary'

  # has_many :parts, class_name: 'MasterFile', :as=>:mediaobject, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
  # belongs_to :governing_policy, class_name: 'Admin::Collection', predicate: ActiveFedora::RDF::ProjectHydra.isGovernedBy
  # belongs_to :collection, class_name: 'Admin::Collection', predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isMemberOfCollection

  belongs_to :governing_policy, class_name: 'Admin::Collection', predicate: ActiveFedora::RDF::ProjectHydra.isGovernedBy
  belongs_to :admin_collection, class_name: 'Admin::Collection', predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isMemberOfCollection
  has_many :parts, class_name: 'MasterFile', as: :mediaobject, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf

  contains 'DC', class_name: 'DublinCoreDocument'
  contains 'descMetadata', class_name: 'ModsDocument'

  # Guarantees that the record is minimally complete - ie that within the descriptive
  # metadata the title, creator, date of creation, and identifier fields are not
  # blank. Since identifier is set automatically we only need to worry about creator,
  # title, and date of creation.
  property :avalon_uploader, delegate_to: :DC, at: [:creator], multiple: false do |index|
    index.as :stored_searchable
  end
  property :avalon_publisher, delegate_to: :DC, at: [:publisher], multiple: false do |index|
    index.as :stored_searchable
  end

  property :title, delegate_to: :descMetadata, at: [:main_title], multiple: false do |index|
    index.as :stored_searchable
  end
  property :alternative_title, delegate_to: :descMetadata, at: [:alternative_title], multiple: true do |index|
    index.as :stored_searchable
  end
  property :translated_title, delegate_to: :descMetadata, at: [:translated_title], multiple: true do |index|
    index.as :stored_searchable
  end
  property :uniform_title, delegate_to: :descMetadata, at: [:uniform_title], multiple: true do |index|
    index.as :stored_searchable
  end
  property :statement_of_responsibility, delegate_to: :descMetadata, at: [:statement_of_responsibility], multiple: false do |index|
    index.as :stored_searchable
  end
  property :creator, delegate_to: :descMetadata, at: [:creator], multiple: true do |index|
    index.as :stored_searchable
  end
  property :date_created, delegate_to: :descMetadata, at: [:date_created], multiple: false do |index|
    index.as :stored_searchable
  end
  property :date_issued, delegate_to: :descMetadata, at: [:date_issued], multiple: false do |index|
    index.as :stored_searchable
  end
  property :copyright_date, delegate_to: :descMetadata, at: [:copyright_date], multiple: false do |index|
    index.as :stored_searchable
  end
  property :abstract, delegate_to: :descMetadata, at: [:abstract], multiple: false do |index|
    index.as :stored_searchable
  end
  property :note, delegate_to: :descMetadata, at: [:note], multiple: true do |index|
    index.as :stored_searchable
  end
  property :format, delegate_to: :descMetadata, at: [:media_type], multiple: false do |index|
    index.as :stored_searchable
  end
  property :resource_type, delegate_to: :descMetadata, at: [:resource_type], multiple: true do |index|
    index.as :stored_searchable
  end


  # # Additional descriptive metadata
  property :contributor, delegate_to: :descMetadata, at: [:contributor], multiple: true do |index|
    index.as :stored_searchable
  end
  property :publisher, delegate_to: :descMetadata, at: [:publisher], multiple: true do |index|
    index.as :stored_searchable
  end
  property :genre, delegate_to: :descMetadata, at: [:genre], multiple: true do |index|
    index.as :stored_searchable
  end
  property :subject, delegate_to: :descMetadata, at: [:topical_subject], multiple: true do |index|
    index.as :stored_searchable
  end
  property :related_item_url, delegate_to: :descMetadata, at: [:related_item_url], multiple: true do |index|
    index.as :stored_searchable
  end
  property :geographic_subject, delegate_to: :descMetadata, at: [:geographic_subject], multiple: true do |index|
    index.as :stored_searchable
  end
  property :temporal_subject, delegate_to: :descMetadata, at: [:temporal_subject], multiple: true do |index|
    index.as :stored_searchable
  end
  property :topical_subject, delegate_to: :descMetadata, at: [:topical_subject], multiple: true do |index|
    index.as :stored_searchable
  end
  property :bibliographic_id, delegate_to: :descMetadata, at: [:bibliographic_id], multiple: false do |index|
    index.as :stored_searchable
  end
  property :language, delegate_to: :descMetadata, at: [:language], multiple: true do |index|
    index.as :stored_searchable
  end
  property :terms_of_use, delegate_to: :descMetadata, at: [:terms_of_use], multiple: false do |index|
    index.as :stored_searchable
  end
  property :physical_description, delegate_to: :descMetadata, at: [:physical_description], multiple: false do |index|
    index.as :stored_searchable
  end

  property :other_identifier, delegate_to: :descMetadata, at: [:other_identifier], multiple: true do |index|
    index.as :stored_searchable
  end
  property :record_identifier, delegate_to: :descMetadata, at: [:record_identifier], multiple: true do |index|
    index.as :stored_searchable
  end
  property :table_of_contents, delegate_to: :descMetadata, at: [:table_of_contents], multiple: true do |index|
    index.as :stored_searchable, type: :string
  end

  contains 'displayMetadata', class_name: 'ActiveFedora::SimpleDatastream' do |sds|
    sds.field :duration, :string
    sds.field :avalon_resource_type, :string
  end

  contains 'sectionsMetadata', class_name:  'ActiveFedora::SimpleDatastream' do |sds|
    sds.field :section_pid, :string
  end

  property :duration, delegate_to: :displayMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :section_pid, delegate_to: :sectionsMetadata, multiple: true do |index|
    index.as :stored_searchable, type: :string
  end
  property :avalon_resource_type, delegate_to: :displayMetadata, multiple: true do |index|
    index.as :stored_searchable, type: :string
  end

  # accepts_nested_attributes_for :parts, :allow_destroy => true
end
