class Timeline < ActiveRecord::Base
  def to_csv
    [started_at, ended_at, project_id]
  end
end
