module LegacyMath
  def self.calculate(a, b, options = {})
    if options[:multiply]
      a * b
    else
      a + b
    end
  end
end
