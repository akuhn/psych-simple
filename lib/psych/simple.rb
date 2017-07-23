require 'psych'

module Psych

  # Load yaml in to a ruby data structure.
  #
  # This function is 2-5x faster as compared to Psych::load but supports a
  # simplified (and safe) data format only. All values are deserialized as
  # strings. Anchors and tags are not supported, and thus ruby objects are
  # not supported either.
  #
  # Options can have the following keys,
  # - filename: used in the exception message (defaults to nil)
  # - symbolize_names: if true return symbols as keys in a yaml mapping,
  #   otherwise strings are returned (defaults to false)
  #
  def self.simple_load(yaml, options = nil)
    parser = Parser.new(SimpleHandler.new(options))
    parser.parse yaml, options && options[:filename]
    parser.handler.document
  end

  class SimpleHandler
    attr_reader :document

    def initialize(options = nil)
      @symbolize_names = options && options[:symbolize_names]
    end

    def start_stream(encoding)
      @stack = Array.new
    end

    def end_stream
      raise unless @stack.empty?
    end

    def start_document(version, tag_directives, implicit)
      raise unless tag_directives.empty?
      @stack.push Array.new
    end

    def end_document(implicit)
      @document = @stack.pop.last
    end

    def start_mapping(anchor, tag, implicit, style)
      raise if anchor or tag
      @stack.push(Array.new)
    end

    def end_mapping
      mapping = Hash.new
      @stack.pop.each_slice(2) do |name, value|
        name = name.to_sym if @symbolize_names
        mapping[name] = value
      end
      @stack.last << mapping
    end

    def start_sequence(anchor, tag, implicit, style)
      raise if anchor or tag
      @stack.push(Array.new)
    end

    def end_sequence
      sequence = @stack.pop
      @stack.last << sequence
    end

    def scalar(value, anchor, tag, plain, quoted, style)
      raise if anchor or tag
      @stack.last << value
    end

    def alias(anchor)
      raise
    end

    def empty
      raise
    end
  end
end
