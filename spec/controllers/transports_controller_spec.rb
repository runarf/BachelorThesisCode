require 'rails_helper'

RSpec.describe TransportsController do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET new" do
    it ""
  end
end