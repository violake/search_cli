# frozen_string_literal: true

## SearchCli Class
#
#  Aim: Create a CLI framework
#
#  Design: a search cli that has help and quit command can also run command by given block
#
#  Concern: made an assumption for 'Enter' to continue as `Enter` is kind of difficult to handle
#           in current structure
#           so add 'next' to start a new search
#
class SearchCli
  COMMAND_PROMPT = '>'
  COMMAND_CONTINUE = :next
  COMMAND_HELP = :help
  COMMAND_QUIT = :quit
  COMMAND_EXIT_HINT = 'Exit Search'

  HELP_MESSAGE = <<~HEREDOC

    =================================================================================================================
    Welcome to Search CLI
    Type 'quit' to exit at any time, 'next' to start a new search, 'help' for command list, Press 'Enter' to continue
    =================================================================================================================

    \s\sSelect search options
    \s\s\s\s* Press 1 to search
    \s\s\s\s* Press 2 to view a list of searchable fields

  HEREDOC

  def initialize(search_hint, searchable_fields)
    @search_hint = search_hint
    @searchable_fields = searchable_fields
    @refresh_search = true
    @in_search = false
  end

  def run
    puts HELP_MESSAGE

    loop do
      print COMMAND_PROMPT

      command = gets.chomp.downcase.to_sym

      case command
      when COMMAND_QUIT
        puts COMMAND_EXIT_HINT
        break
      when COMMAND_CONTINUE
        new_search
      else
        in_search? ? yield(command, refresh_search?) : options(command)
      end
    end
  end

  private

  def refresh_search?
    if @refresh_search
      @refresh_search = false
      true
    else
      false
    end
  end

  def new_search
    return unless in_search?

    puts 'New search'
    @in_search = false
    @refresh_search = true
  end

  def set_in_search
    @in_search = true
  end

  def in_search?
    @in_search
  end

  def options(command)
    case command
    when :'1'
      puts @search_hint
      set_in_search
    when :'2'
      puts @searchable_fields
    when COMMAND_HELP
      puts HELP_MESSAGE
    else
      puts "Error Input: '#{command}', try 'help' for correct commands"
    end
  end

  # adapt docker-compose input
  def gets
    if ARGV.nil?
      Kernel.gets
    else
      $stdin.gets
    end
  end
end
