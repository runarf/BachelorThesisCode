require 'test_helper'
require 'rails/performance_test_help'

class ApiTest < ActionDispatch::PerformanceTest
  def test_homepage
    get '/'
  end

  def test_api
    from = "Asperudtoppen, Oslo, Norway"
    to = "Moldeveien 1, Oslo, Norway"
    get '/'
    post '/trips', from: from, to: to
  end
end