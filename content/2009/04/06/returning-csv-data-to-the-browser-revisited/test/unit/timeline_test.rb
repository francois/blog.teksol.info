require 'test_helper'

class TimelineTest < ActiveSupport::TestCase
  def test_to_csv
    timeline = Timeline.first
    assert_match [timeline.started_at.to_s(:db), timeline.ended_at.to_s(:db), timeline.project_id].join(","), timeline.to_csv
  end

  def test_to_csv_does_not_have_newline
    assert_nil Timeline.first.to_csv["\n"]
  end
end
