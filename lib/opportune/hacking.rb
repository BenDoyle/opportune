class Sampler
  attr_reader :hash
  def initialize(hash, random = Random.new)
    @hash = hash
    @r = random
    @internal = {}
    @total = hash.values.inject(0.0){|s,e|s+e}
    range_min = 0.0
    hash.each_pair do |k,v|
      @internal[range_min...range_min+v.to_f] = k
      range_min += v.to_f
    end
  end
  def sample
    r   = @r.rand(@total)
    key = @internal.keys.find{|k| k === r }
    @internal[key]
  end
end

class Action
  def initialize(outcome_weights)
    @total_weight = outcome_weights.values.inject(0.0){|s,e|s+e}
    @sampler = Sampler.new(outcome_weights)
  end
  def perform
    @sampler.sample
  end
  def avg_outcome_value
    total = 0.0
    @sampler.hash.each_pair do |k,v|
      total += k.value * v.fdiv(@total_weight)
    end
    total
  end
  def var_outcome_value
    total = 0.0
    @sampler.hash.each_pair do |k,v|
      total += (k.value ** 2) * v.fdiv(@total_weight)
    end
    total - avg_outcome_value ** 2
  end
end

class Outcome
  attr_reader :value
  def initialize(value)
    @value = value
  end
end

class Scenario
  attr_reader :actions
  def initialize(actions, outcomes, seed = Time.now.to_i)
    @actions = []
    r = Random.new(seed)
    actions.times do |i|
      outcome_weights = {}
      outcomes.times do |j|
        outcome_weights[Outcome.new(j)] = r.rand
      end
      @actions << Action.new(outcome_weights)
    end
  end
end

