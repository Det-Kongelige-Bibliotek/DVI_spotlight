##
# Simplified catalog controller
class CatalogController < ApplicationController
  include Blacklight::Catalog

  # Hack to get blacklight to URL decode id param before fetching from solr
  before_action :url_decode_id, :only => [:show, :edit]
  def url_decode_id
    params[:id] = URI.unescape(params[:id])
  end

  configure_blacklight do |config|
    config.show.oembed_field = :oembed_url_ssm
    config.show.partials.insert(1, :oembed)


    config.view.gallery.partials = [:index_header, :index]
    config.view.masonry.partials = [:index]
    config.view.slideshow.partials = [:index]


    config.show.tile_source_field = :content_metadata_image_iiif_info_ssm
    config.show.partials.insert(1, :openseadragon)
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = {
        qt: 'search',
        rows: 10,
        fl: '*'
    }

    config.document_solr_path = 'get'
    config.document_unique_id_param = 'ids'

    # solr field configuration for search results/index views
    config.index.title_field = :full_title_tsim

    config.add_search_field 'all_fields', label: 'Everything' do |field|
      # Free text search in these fields: title, creator, description
      field.solr_local_parameters = {
          :qf => 'cobject_title_ssi^100 full_title_tsim^90 creator_tsim^80 description_tsim^50'
      }
    end

    config.add_sort_field 'relevance', sort: 'score desc', label: 'Relevance'

    config.add_field_configuration_to_solr_request!

    config.add_index_field 'title_tdsim', :label => 'Titel'
    config.add_index_field 'type_tdsim', :label => 'Ressourcetype'
    config.add_index_field 'readable_dat_string_tsim', :label => 'Oprindelsesdato'
    config.add_index_field 'subject_tdsim', :label => 'Emne'
    config.add_index_field 'coverage_tdsim', :label => 'Lokalitet'
    config.add_index_field 'local_id_ssi', :label => 'Id'
    config.add_index_field 'shelf_mark_tdsim', :label => 'Opstilling'

    config.add_facet_field 'subject_topic_facet_ssim', :label => 'Emne', :single => true, :limit => 10 , sort: 'count'
    config.add_facet_field 'readable_dat_string_tsim', :label => 'Oprindelsesdato', :single => true, :limit => 10

    config.add_facet_fields_to_solr_request!
    # Hide bookmark from index page and landing page
    config.index.document_actions.delete(:bookmark)
    config.show.document_actions.delete(:bookmark)


  end
end
