class ApplicationController < ActionController::Base
  helper Openseadragon::OpenseadragonHelper
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  include Spotlight::Controller
  # Makes changing the language throught URL  fx: /spotlight/the-west-indies?locale=da
  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { :locale => I18n.locale == I18n.default_locale ? nil : I18n.locale  } # If current locale is equal to the default locale do not show it in the url
  end

  layout 'blacklight'

  protect_from_forgery with: :exception
end
