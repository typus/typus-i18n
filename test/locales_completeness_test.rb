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
    load_translations_into_i18n!
  end
  
  def load_translations_into_i18n!
    if !@loaded
      Dir.glob('config/locales/*.yml').each do |file|
        content = YAML.load_file(file)
        language = content.keys.first
        I18n.backend.store_translations(language.to_sym, content[language])
      end
      @loaded = true
    end
  end

  class << self

    def all_locales
      %w(de)
    end

    def all_keys
      @all_keys ||= begin
        reference_file = Admin::Engine.root.join("config/locales/typus.#{REFERENCE_LOCALE}.yml")
        data = YAML.load_file(reference_file)[REFERENCE_LOCALE]
        translations = I18n.backend.flatten_translations(REFERENCE_LOCALE, data, false, false)
        translations.keys
      end
    end

  end

  all_locales.each do |current_locale|
    all_keys.each do |key|
      define_method("test_#{current_locale}_has_#{key.to_s.gsub('.', '_')}") do
        I18n.locale = current_locale
        msg = "Locale #{current_locale} has no translation for: #{key}."
        refute(I18n.t(key).include?("translation missing"), msg)
      end
    end
  end

end