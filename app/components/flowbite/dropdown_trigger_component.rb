# frozen_string_literal: true

class Flowbite::DropdownTriggerComponent < Flowbite::TriggerBaseComponent
  has_option :delay, default: 300

  def before_render
    super

    html_attributes[:class] = classnames theme.classname("root.base"), html_class
  end

  def stimulus_controller_options
    super.merge delay: delay,
                open_classes: theme.classname("root.open"),
                closed_classes: theme.classname("root.closed")
  end

  class StimulusController < Flowbite::ViewComponents::StimulusController
    TRIGGER_TYPES = {
      hover: {
        show: :click,
        hoverShow: :mouseenter,
        hoverHide: :mouseleave
      },
      click: {
        toggle: :click
      }
    }.freeze

    def dropdown_identifier
      Flowbite::DropdownComponent.stimulus_controller_identifier
    end

    def attributes(options = {})
      trigger_type = options[:trigger_type]&.to_sym
      attributes = super options
      attributes[:data][value_key(:delay)] = options[:delay]
      attributes[:data][outlet_key(dropdown_identifier)] = options[:selector]
      attributes[:data][classes_key(:open)] = options[:open_classes]
      attributes[:data][classes_key(:closed)] = options[:closed_classes]
      attributes[:data][:action] = build_actions(TRIGGER_TYPES[trigger_type])
      attributes
    end
  end
end
