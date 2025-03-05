# frozen_string_literal: true

require 'json'

class JsonDao
  def self.read
    file = File.read('./lib/data_source/client.json')

    JSON.parse(file, symbolize_names: true)
  end
end
