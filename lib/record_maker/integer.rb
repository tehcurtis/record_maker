class RecordMaker
  class Integer
    class << self
      def generate
        rand(20_000_000)
      end
    end
  end
end
