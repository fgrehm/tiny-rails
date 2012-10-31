class TinyRailsController < ActionController::Base
  # Code reloading goodness
  require_dependency 'models'

  append_view_path File.dirname(__FILE__)

  def index
    @model = SampleModel.new
    render :template => 'index'
  end
end
