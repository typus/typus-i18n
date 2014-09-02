require "minitest/autorun"
require 'rails'
require 'typus'
require 'yaml'

require "i18n/backend/flatten"
I18n::Backend::Simple.send(:include, I18n::Backend::Flatten)
I18n.enforce_available_locales = false

class LocalesCompletenessTest < Minitest::Test

  REFERENCE_LOCALE = "en"

  def self.locales_to_test
    files = Dir.glob(File.join(File.dirname(__FILE__), '../config/locales/typus.*.yml'))
    files.map { |file| YAML.load_file(file).keys.first.to_s }
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

  def locale_keys(locale)
    translations(locale).keys
  end

  def all_keys
    locale_keys(REFERENCE_LOCALE)
  end

  locales_to_test.each do |locale|

    define_method("test_#{locale}_is_complete") do
      difference = all_keys - locale_keys(locale)
      msg = %(The locale "#{locale}" is missing translations. Please add translations for the keys listed below)
      assert_equal [], difference, msg
    end

    # WIP
    # define_method("test_#{locale}_has_no_empty_translations") do
    #   I18n.backend.load_translations(translations(REFERENCE_LOCALE))
    #   I18n.backend.load_translations(locale)
    #   I18n.locale = locale
    #   all_keys.each do |key|
    #     p I18n.t(key)
    #     refute_equal "", I18n.t(key)
    #   end
    # end

    define_method("test_#{locale}_has_no_obsolete_keys") do
      difference = locale_keys(locale) - all_keys
      msg = %(The locale "#{locale}" has obsolete translations. Please remove the keys listed below)
      assert_equal [], difference, msg
    end

  end

end
