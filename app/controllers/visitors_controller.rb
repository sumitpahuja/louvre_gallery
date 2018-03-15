class VisitorsController < ApplicationController
  def index
    # get method: action for user to upload the file
  end

  def import
    # method to analyse the logger file and display result
    @result = VisitorRoom.process_csv(params[:file])
  end
end
