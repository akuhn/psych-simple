require 'psych'

module Psych
  def self.simple_load(yaml, filename = nil)
    parser = Parser.new(SimpleHandler.new)
    parser.parse yaml, filename
    parser.handler.document
  end

  class SimpleHandler
    attr_reader :document

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
      mapping = Hash[*@stack.pop]
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
