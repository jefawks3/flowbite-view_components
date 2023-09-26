# frozen_string_literal: true

class Flowbite::Tabs::TabComponent < Flowbite::ClickableComponent
  has_option :tabs_id
  has_option :variant, default: :default
  has_option :selected, type: :boolean, default: false
  has_option :panel_id

  renders_one :left_visual, types: {
    icon: {
      as: :left_icon,
      renders: lambda { |icon, options = {}|
        options[:class] = classnames theme.apply(:visual, self, { position: :left }), options[:class]
        Flowbite::IconBaseComponent.new icon, options
      }
    },
    svg: {
      as: :left_svg,
      renders: lambda { |path, options = {}|
        options[:class] = classnames theme.apply(:visual, self, { position: :left }), options[:class]
        Flowbite::InlineSvgComponent.new path, options
      }
    },
    image: {
      as: :left_image,
      renders: lambda { |source, options = {}|
        options[:class] = classnames theme.apply(:visual, self, { position: :left }), options[:class]
        image_tag source, options
      }
    }
  }

  renders_one :right_visual, types: {
    icon: {
      as: :right_icon,
      renders: lambda { |icon, options = {}|
        options[:class] = classnames theme.apply(:visual, self, { position: :right }), options[:class]
        Flowbite::IconBaseComponent.new icon, options
      }
    },
    svg: {
      as: :right_svg,
      renders: lambda { |path, options = {}|
        options[:class] = classnames theme.apply(:visual, self, { position: :right }), options[:class]
        Flowbite::InlineSvgComponent.new path, options
      }
    },
    image: {
      as: :right_image,
      renders: lambda { |source, options = {}|
        options[:class] = classnames theme.apply(:visual, self, { position: :right }), options[:class]
        image_tag source, options
      }
    }
  }

  def visuals?
    left_visual? || right_visual?
  end

  def before_render
    super

    html_attributes[:role] = :tab
    html_attributes[:aria] ||= {}
    html_attributes[:aria][:selected] = selected?
    html_attributes[:aria][:controls] = panel_id if panel_id?
  end

  def call
    super do
      concat left_visual if left_visual?
      concat content
      concat right_visual if right_visual?
    end
  end

  def use_stimulus?
    !disabled? && super
  end

  def stimulus_controller_options
    {
      selected: selected?,
      active_classes: active_classes,
      selected_classes: selected_classes,
      siblings: tabs_id? ? "##{tabs_id} [data-controller~='flowbite--tab']" : nil,
      panel: panel_id? ? "##{panel_id}" : nil,
    }
  end

  protected

  def root_classes
    super do
      selected_classes if selected?
    end
  end

  def selected_classes
    theme.apply("root/selected", self)
  end

  class << self
    def stimulus_controller_name
      :tab
    end
  end

  class StimulusController < Flowbite::ViewComponents::StimulusController
    def attributes(options = {})
      attributes = super
      attributes[:data][value_key(:selected)] = options[:selected]
      attributes[:data][classes_key(:active)] = options[:active_classes]
      attributes[:data][classes_key(:selected)] = options[:selected_classes]
      attributes[:data][outlet_key("flowbite--tab")] = options[:siblings]
      attributes[:data][outlet_key("flowbite--collapsible")] = options[:panel]
      attributes[:data][:action] = action(:select)
      attributes
    end
  end
end
