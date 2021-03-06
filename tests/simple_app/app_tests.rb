# encoding: utf-8
$:.unshift File.join(File.dirname(__FILE__),'..')
$:.unshift File.dirname(__FILE__)
require "test_helper"
require "app"

class GetResponseFake
  def get_response_body(uri)
    if (uri.path.include?("querystation"))
      return GetStartEndPoint.new.get_querystation 
    end
    if (uri.path.include?("resultspage"))
      return GetJourney.new.get_resultspage
    end
    raise "Uri?"
  end
end

class AppTests < Test::Unit::TestCase
  def setup
    @app = App.new(:get_response=>GetResponseFake.new)
  end
  def test_get_times
    @app.get_times("Lund","Malmö",Time.now)
  end
end
