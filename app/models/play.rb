class Play < ActiveRecord::Base

  has_many :players

  # :: [{ q: String, a: [String] }]
  def data_obj
    @_data_obj ||= JSON.parse(data)
  end

  # :: [Int]
  def decision_array
    @_decision_array ||= JSON.parse(decision)
  end

  # :: Bool
  def started?
    self.step > 0
  end

  # :: Bool
  def finished?
    last?(step)
  end

  # :: Int -> Bool
  def first?(step)
    step <= 1
  end

  # :: Int -> Bool
  def last?(step)
    step >= data_obj.size
  end

  # :: Int -> (Int | Nil)
  def decision_of(step)
    decision_array[step - 1]
  end

  # :: (Int, Int) -> Nil
  def decide(step, ix)
    ary = decision_array.dup
    ary[step - 1] = ix
    self.decision = ary.to_json
    save!
  end

  # :: () -> Nil
  def next_step
    self.step += 1
    save!
  end

  def results_data_table
    data_table = players.map {|pl| [pl.name, pl.total_score(self)] }
    data_table.sort {|a, b| b[1] <=> a[1]}
  end

  def max_score
    self.decision_array.size - 1;
  end
end

