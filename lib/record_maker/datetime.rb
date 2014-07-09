class RecordMaker
  class Datetime
    class << self
      def generate
        Time.at(rand * Time.now.to_i)
      end
    end
  end
end
