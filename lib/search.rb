# frozen_string_literal: true

require 'search_cli'
require 'data_importer/json_dao'
require 'data_query/json_query'

class Search
  NEXT_VALUE_OR_NEXT_SEARCH = "try searching another value? or type 'next' to start a new search"
  ENTER_SEARCH_VALUE = "Enter search value or 'check' to find duplication"
  EMPTY_RESULT = 'No Result Found'
  CHECK_DUPLICATION = :check

  def initialize
    @search_field = nil
    @data = JsonDao.read
    @query = JsonQuery.new(@data)
  end

  def start
    SearchCli.new(search_hint, searchable_fields).run do |command, refresh_search|
      @search_field = nil if refresh_search

      case command
      when CHECK_DUPLICATION
        exec_search_duplication(command)
      else
        exec_search_field(command)
      end
    rescue StandardError => e
      puts e.message
    end
  end

  private

  def exec_search_field(command)
    if search_field_selected?
      format_output(@query.find_all(@search_field, command))
      puts NEXT_VALUE_OR_NEXT_SEARCH
    else
      select_search_field(command)
      puts ENTER_SEARCH_VALUE
    end
  end

  def exec_search_duplication(command)
    if search_field_selected?
      format_output(@query.find_duplicate_data(@search_field))
      puts NEXT_VALUE_OR_NEXT_SEARCH
    else
      select_search_field(command)
      puts ENTER_SEARCH_VALUE
    end
  end

  def format_output(search_result)
    output = search_result.empty? ? 'No record found' : search_result

    puts output
  end

  def search_field_selected?
    !@search_field.nil?
  end

  def select_search_field(field)
    unless searchable_fields.include?(field)
      raise UnknownSearchFieldError, "Field(#{field}) is not valid! Please choose from #{searchable_fields}"
    end

    @search_field = field
  end

  def search_hint
    "Start to search. Please choose a field from #{searchable_fields}. "
  end

  def searchable_fields
    [:full_name]
  end
end

class UnknownSearchFieldError < StandardError; end
