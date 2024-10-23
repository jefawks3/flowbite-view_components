# frozen_string_literal: true

class FoxTail::StepperComponent < FoxTail::BaseComponent
  renders_many :steps, lambda { |options = {}|
    options[:variant] = variant
    options[:theme] = theme.theme :step
    options[:index] ||= @index += 1
    FoxTail::Stepper::StepComponent.new options
  }

  has_option :variant, default: :default

  def initialize(html_attributes = {})
    super

    @index = 0
  end

  def render?
    steps?
  end

  def before_render
    super

    html_attributes[:class] = classnames theme.apply(:root, self), html_class
  end

  def call
    content_tag :ol, html_attributes do
      steps.each { |step| concat step }
    end
  end
end
