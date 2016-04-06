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

class MasterFile < ActiveFedora::Base
  # include ActiveFedora::Associations
  # include Hydra::AccessControls::Permissions
  # include Hooks
  # include Rails.application.routes.url_helpers
  # include Permalink
 # include VersionableModel

  # WORKFLOWS = ['fullaudio', 'avalon', 'avalon-skip-transcoding', 'avalon-skip-transcoding-audio']

  # belongs_to :mediaobject, :class_name=>'MediaObject', :predicate=>ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
  # has_many :derivatives, :class_name=>'Derivative', :as=>:masterfile, :predicate=>ActiveFedora::RDF::Fcrepo::RelsExt.isDerivationOf

  contains 'descMetadata', class_name: 'ActiveFedora::SimpleDatastream' do |d|
    d.field :label, :string
    d.field :file_location, :string
    d.field :file_checksum, :string
    d.field :file_size, :string
    d.field :duration, :string
    d.field :display_aspect_ratio, :string
    d.field :original_frame_size, :string
    d.field :file_format, :string
    d.field :poster_offset, :string
    d.field :thumbnail_offset, :string
  end

  contains 'mhMetadata', class_name: 'ActiveFedora::SimpleDatastream' do |d|
    d.field :workflow_id, :string
    d.field :workflow_name, :string
    d.field :mediapackage_id, :string
    d.field :percent_complete, :string
    d.field :percent_succeeded, :string
    d.field :percent_failed, :string
    d.field :status_code, :string
    d.field :operation, :string
    d.field :error, :string
    d.field :failures, :string
  end

  contains 'masterFile', class_name: 'UrlDatastream'

  property :label, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :file_checksum, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :file_size, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :duration, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :display_aspect_ratio, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :original_frame_size, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :file_format, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :poster_offset, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :thumbnail_offset, delegate_to: :descMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end

  property :workflow_id, delegate_to: :mhMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :workflow_name, delegate_to: :mhMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :mediapackage_id, delegate_to: :mhMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :percent_complete, delegate_to: :mhMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :percent_succeeded, delegate_to: :mhMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :percent_failed, delegate_to: :mhMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :status_code, delegate_to: :mhMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :operation, delegate_to: :mhMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :error, delegate_to: :mhMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end
  property :failures, delegate_to: :mhMetadata, multiple: false do |index|
    index.as :stored_searchable, type: :string
  end

  contains 'thumbnail'
  contains 'poster'
  contains 'structuralMetadata', class_name: 'StructuralMetadata'
  contains 'captions'
end
