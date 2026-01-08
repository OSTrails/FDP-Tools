# frozen_string_literal: false


require_relative '../../lib/fdp_tools'
require_relative "models"
require_relative "routes"

module FdpTools
  class Main < Sinatra::Application

    set_routes
  end
end
FdpTools::Main.run! if __FILE__ == $0
