class ApplicationController < ActionController::Base
  append_view_path File.dirname(__FILE__)

  def index
    render :template => 'index'
  end
end
