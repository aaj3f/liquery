class CorrectDataJob

  def call
    Drink.all.each do |drink|
      drink.measures.each do |m|
        if m.size && m.size == 0.0
          m.size, m.note = nil, "variable measure"
          m.save
          drink.save
        end
        puts "#{"#{m.size} parts " if m.size}#{m.ingredient.name}#{" (NOTE: #{m.note})" if m.note}"
      end
      binding.pry
    end
  end
end

# FlavorProfiles:
# 1. "Stiff"
# 2. "Creamy"
# 3. "Bitter"
# 4. "Bright"
# 5. "Sweet"

#destroy: 59, 60, 63, 72, 73, 81, 83, 131
