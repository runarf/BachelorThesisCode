class Trip < ActiveRecord::Base
  has_many :stages

  def find_next_
    if self.stages.first.travelType == :walking

    else

    end
  end
end
