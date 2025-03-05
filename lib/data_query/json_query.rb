# frozen_string_literal: true

class JsonQuery
  def initialize(data)
    @data = data
  end

  def find_all(field, value)
    @data.select { |item| item[field].match?(/#{value}/i) }
  end

  def find_duplicate_data(field)
    grouped_data = @data.group_by { |item| item[field] }

    grouped_data.select { |_field, items| items.size > 1 }
  end
end
