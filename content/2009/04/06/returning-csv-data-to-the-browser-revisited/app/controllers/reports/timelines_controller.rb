class Reports::TimelinesController < ApplicationController
  def show
    @timelines = Timeline.all
    respond_to do |format|
      format.csv do
        response.headers["Content-Type"]        = "text/csv; charset=UTF-8; header=present"
        response.headers["Content-Disposition"] = "attachment; filename=timeline-report.csv"
      end
    end
  end
end
