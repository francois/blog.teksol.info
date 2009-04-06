require 'test_helper'

class Reports::TimelinesControllerTest < ActionController::TestCase
  def test_get_show_with_csv_format_returns_csv_data
    get :show, :format => "csv"

    assert_response :success
    assert_template "show"
    assert_equal "text/csv; charset=UTF-8; header=present", @response.headers["Content-Type"]
    assert_equal "attachment; filename=timeline-report.csv", @response.headers["Content-Disposition"]
  end
end
