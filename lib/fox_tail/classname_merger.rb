# frozen_string_literal: true

require "tailwind_merge"

module FoxTail
  # Tailwind CSS class name merger
  class ClassnameMerger
    def initialize
      @base_merger = TailwindMerge::Merger.new
    end

    # Merge Tailwind class names removing any styling conflicts
    def merge(*classes)
      normalized = classes.flatten.compact_blank.map(&:to_s)
      return nil if normalized.empty?

      @base_merger.merge normalized.join(" ")
    end
  end
end
