class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def create
    ReportGenerator.generate(params[:title], params[:content], true)
  end
end
