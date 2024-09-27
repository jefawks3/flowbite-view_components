require 'test_helper'

class FoxTail::ConfigTest < ActiveSupport::TestCase
  def test_default_classname_merger
    assert_kind_of FoxTail::ClassnameMerger, FoxTail::Config.defaults.classname_merger
  end

  def test_default_stimulus_merger
    assert_kind_of FoxTail::StimulusMerger, FoxTail::Config.defaults.stimulus_merger
  end

  def test_default_use_stimulus_true
    assert FoxTail::Config.defaults.use_stimulus
  end

  def test_default_raise_on_asset_not_found_true
    assert FoxTail::Config.defaults.raise_on_asset_not_found
  end

  def test_default_color_theme_options
    assert_empty FoxTail::Config.defaults.color_theme
  end

  def test_default_icon_sets_option
    assert_empty FoxTail::Config.defaults.icon_sets
  end

  def test_default_icon_set_name
    assert_nil FoxTail::Config.defaults.default_icon_set
  end

  def test_default_icon_variant
    assert_equal :solid, FoxTail::Config.defaults.default_icon_variant
  end
end
