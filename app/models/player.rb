class Player < ActiveRecord::Base

  belongs_to :play
  scope :with_play, -> { eager_load(:play) }

  # :: [Int]
  def decision_array
    @_decision_array ||= JSON.parse(decision)
  end

  # :: (Int, Int) -> Nil
  def decide(step, value)
    if play.decision_of(step)
      Rails.logger.error "Already answered."
      return
    end
    ary = decision_array
    ary[step - 1] = value
    self.decision = ary.to_json
    save!
  end
  # :: Play -> Int
  def total_score(play)
    sum = 0;
    play.decision_array.each_with_index{|v, i|
      sum += 1 if v == decision_array[i] && i != 0 # exclude an example
    }
    sum
  end
end

