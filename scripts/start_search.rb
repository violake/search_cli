#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry'
$LOAD_PATH.unshift('./lib')
require 'search'

Search.new.start
