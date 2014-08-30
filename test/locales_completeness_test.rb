require "minitest/autorun"
require 'rails'
require 'typus'
require 'yaml'

require "i18n/backend/flatten" 
I18n::Backend::Simple.send(:include, I18n::Backend::Flatten)

class LocalesCompletenessTest < Minitest::Test
  
  REFERENCE_LOCALE = "en"
  
  def setup
    I18n.enforce_available_locales = false
  end

  class << self

    def locales_to_test
      %w(de)
    end

    def locale_file(locale)
      if (locale == REFERENCE_LOCALE)
        Admin::Engine.root.join("config/locales/typus.#{locale}.yml")
      else
        File.join(File.dirname(__FILE__), "../config/locales/typus.#{locale}.yml")
      end
    end

    def translations(locale)
      file = locale_file(locale)
      data = YAML.load_file(file)[locale]
      I18n.backend.flatten_translations(locale, data, false, false)
    end

    def reference_keys
      @reference_keys ||= translations(REFERENCE_LOCALE).keys
    end

  end

  locales_to_test.each do |current_locale|

    #
    # test all translated locales are complete, i.e. contain all keys that are in the gem
    #
    define_method("test_#{current_locale}_is_complete") do
      reference_keys = self.class.reference_keys
      locale_keys    = self.class.translations(current_locale).keys
      difference = reference_keys - locale_keys
      msg = %(The locale "#{current_locale}" is missing translations. Please add translations for the keys listed below)
      assert_equal [], difference, msg
    end

    #
    # test the translated locales have no obsolete keys
    #
    define_method("test_#{current_locale}_has_no_obsolete_keys") do
      reference_keys = self.class.reference_keys
      locale_keys    = self.class.translations(current_locale).keys
      difference = locale_keys - reference_keys
      msg = %(The locale "#{current_locale}" has obsolete translations. Please remove the keys listed below)
      assert_equal [], difference, msg
    end

  end

end