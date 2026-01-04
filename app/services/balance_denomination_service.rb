class BalanceDenominationService
  def initialize(balance_amount:)
    @balance = balance_amount.to_i
  end

  def call
    results = []

    Denomination.order(value: :desc).each do |denomination|
      break if @balance.zero?

      max_notes = @balance / denomination.value
      usable_notes = [max_notes, denomination.available_count].min

      if usable_notes.positive?
        results << {
          value: denomination.value,
          count: usable_notes
        }

        @balance -= denomination.value * usable_notes
      end
    end

    results
  end
end
