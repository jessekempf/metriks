require 'atomic'

module Metriks
  class Gauge
    # Public: Initialize a new Gauge.
    def initialize(callable = nil, &block)
      @gauge = Atomic.new(nil)
      @callback = callable || block
    end

    # Public: Set a new value.
    #
    # val - The new value.
    #
    # Returns nothing.
    def set(val)
      @gauge.value = val
    end

    # Public: The current value.
    #
    # Returns the gauge value.
    def value
      @callback ? @callback.call : @gauge.value
    end

    # Private: The fields that should be reported to a metrics consumer.
    #
    # Returns an array of symbols.
    def reportable_fields
      [
        :value
      ]
    end
  end
end
