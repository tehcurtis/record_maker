require_relative 'record_maker/integer'
require_relative 'require_maker/string'

class RecordMaker
  attr_reader :source_class, :columns, :number_to_create

  def initialize(source_class, options={})
    @source_class = source_class
    @columns = source_class.columns
    @number_to_create = options[:create].to_i || 0
  end

  # actually make the desired number of records
  def make!
    (1..(number_to_create)).each do |num|
      inst = @source_class.new
      columns.each do |col|
        next if attributes_to_skip.any? {|a| a.to_s == col.name}

        inst.send("#{col.name}=", data_for_type(col.type, col.limit))
      end
      inst.save!
    end
  end

  private

  def data_for_type(col_type, length=nil)
    d = {
      integer: RecordMaker::Integer.generate,
      string: RecordMaker::String.generate,
      datetime: RecordMaker::Datetime.generate,
      boolean: true,
      text: 'this is some gnarly text herah. so keep reading, reading, and reading',
      decimal: BigDecimal('2.3')
    }[col_type]

    d = d[0..length-1] unless length.nil?

    d
  end

  def attributes_to_skip
    [:id, :created_at, :updated_at]
  end
end
