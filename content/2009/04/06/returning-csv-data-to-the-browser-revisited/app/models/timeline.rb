require "fastercsv"

class Timeline < ActiveRecord::Base
  default_scope :order => "started_at ASC"

  def to_csv
    FasterCSV.generate_line([started_at.to_s(:db), ended_at.to_s(:db), project_id]).chomp
  end
end
