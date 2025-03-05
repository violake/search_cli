# frozen_string_literal: true

require 'search_cli'

class Search
  NEXT_VALUE_OR_NEXT_SEARCH = "try another value? or type 'next' to start a new search"
  ENTER_SEARCH_VALUE = 'Enter search value'
  EMPTY_RESULT = 'No Result Found'

  def initialize
    @search_field = nil
  end

  def start
    SearchCli.new(search_hint, searchable_fields).run do |command, refresh_search|
      @search_field = nil if refresh_search

      case true # rubocop:disable Lint/LiteralAsCondition
      when search_field_selected?
        search_value(command)
        puts NEXT_VALUE_OR_NEXT_SEARCH
      else
        select_search_field(command)
        puts ENTER_SEARCH_VALUE
      end
    rescue StandardError => e
      puts e.message
    end
  end

  private

  def search_value(value)
    puts "search #{@search_field} with value (#{value})"
  end

  def search_field_selected?
    !@search_field.nil?
  end

  def select_search_field(field)
    @search_field = field
  end

  def search_hint
    'Start to search'
  end

  def searchable_fields
    'name'
  end
end
