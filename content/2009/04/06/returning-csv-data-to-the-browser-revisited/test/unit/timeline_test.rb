require 'test_helper'

class TimelineTest < ActiveSupport::TestCase
  def test_to_csv
    timeline = Timeline.first
    assert_equal [timeline.started_at, timeline.ended_at, timeline.project_id], timeline.to_csv
  end
end
