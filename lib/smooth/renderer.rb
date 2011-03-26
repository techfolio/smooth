module Smooth
  class Renderer

    attr_writer :layout

    def initialize(template)
      @template = template

      @context = Context.new
    end

    def render!
      result = Haml::Engine.new(@template).render(@context)
      result = Haml::Engine.new(@layout).render(@context) if @layout
      result
    end

    def result
      @result ||= render!
    end

    def register_helpers(mod)
      @context.register_helpers mod
    end

    class Context
      def singleton_class
        class << self; self; end
      end

      def register_helpers(mod)
        singleton_class.class_eval do
          include mod
        end
      end
    end
  end
end
