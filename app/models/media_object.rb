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

  # has_many :parts, :class_name=>'MasterFile', :as=>:mediaobject, :predicate=>ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
  # belongs_to :governing_policy, :class_name=>'Admin::Collection', :predicate=>ActiveFedora::RDF::ProjectHydra.isGovernedBy
  # belongs_to :collection, :class_name=>'Admin::Collection', :predicate=>ActiveFedora::RDF::Fcrepo::RelsExt.isMemberOfCollection

  contains "DC", class_name: 'DublinCoreDocument'
  contains "descMetadata", class_name: 'ModsDocument'

  # Guarantees that the record is minimally complete - ie that within the descriptive
  # metadata the title, creator, date of creation, and identifier fields are not
  # blank. Since identifier is set automatically we only need to worry about creator,
  # title, and date of creation.
  has_attributes :avalon_uploader, datastream: :DC, at: [:creator], multiple: false
  has_attributes :avalon_publisher, datastream: :DC, at: [:publisher], multiple: false
  # Delegate variables to expose them for the forms
  has_attributes :title, datastream: :descMetadata, at: [:main_title], multiple: false
  has_attributes :alternative_title, datastream: :descMetadata, at: [:alternative_title], multiple: true
  has_attributes :translated_title, datastream: :descMetadata, at: [:translated_title], multiple: true
  has_attributes :uniform_title, datastream: :descMetadata, at: [:uniform_title], multiple: true
  has_attributes :statement_of_responsibility, datastream: :descMetadata, at: [:statement_of_responsibility], multiple: false
  has_attributes :creator, datastream: :descMetadata, at: [:creator], multiple: true
  has_attributes :date_created, datastream: :descMetadata, at: [:date_created], multiple: false
  has_attributes :date_issued, datastream: :descMetadata, at: [:date_issued], multiple: false
  has_attributes :copyright_date, datastream: :descMetadata, at: [:copyright_date], multiple: false
  has_attributes :abstract, datastream: :descMetadata, at: [:abstract], multiple: false
  has_attributes :note, datastream: :descMetadata, at: [:note], multiple: true
  has_attributes :format, datastream: :descMetadata, at: [:media_type], multiple: false
  has_attributes :resource_type, datastream: :descMetadata, at: [:resource_type], multiple: true
  # Additional descriptive metadata
  has_attributes :contributor, datastream: :descMetadata, at: [:contributor], multiple: true
  has_attributes :publisher, datastream: :descMetadata, at: [:publisher], multiple: true
  has_attributes :genre, datastream: :descMetadata, at: [:genre], multiple: true
  has_attributes :subject, datastream: :descMetadata, at: [:topical_subject], multiple: true
  has_attributes :related_item_url, datastream: :descMetadata, at: [:related_item_url], multiple: true

  has_attributes :geographic_subject, datastream: :descMetadata, at: [:geographic_subject], multiple: true
  has_attributes :temporal_subject, datastream: :descMetadata, at: [:temporal_subject], multiple: true
  has_attributes :topical_subject, datastream: :descMetadata, at: [:topical_subject], multiple: true
  has_attributes :bibliographic_id, datastream: :descMetadata, at: [:bibliographic_id], multiple: false

  has_attributes :language, datastream: :descMetadata, at: [:language], multiple: true
  has_attributes :terms_of_use, datastream: :descMetadata, at: [:terms_of_use], multiple: false
  has_attributes :physical_description, datastream: :descMetadata, at: [:physical_description], multiple: false

  contains 'displayMetadata', class_name: 'ActiveFedora::SimpleDatastream' do |sds|
    sds.field :duration, :string
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

  # accepts_nested_attributes_for :parts, :allow_destroy => true
end
