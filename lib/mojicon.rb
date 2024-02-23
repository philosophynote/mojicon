# frozen_string_literal: true

require_relative "mojicon/version"
require "mojicon/converter"

class String
  include Mojicon::Converter
  class Error < StandardError; end
end
