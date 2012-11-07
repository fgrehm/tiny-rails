class TinyRailsController < ActionController::Base
  # TODO: Add "require_dependency 'models'" if an ORM is added

  append_view_path File.dirname(__FILE__)

  def index
    render :template => 'index'
  end
end
