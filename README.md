[![Build Status](https://api.travis-ci.org/typus/typus-i18n.svg)](https://travis-ci.org/typus/typus-i18n)

# Welcome to typus-18n!

This gem's (only) purpose is to provide the YAML translation files for typus.


## Currently available languages

- en: English (provided by the typus gem itself)
- de: German
- Soon: your language? It's easy, see below.


## Installation and usage

- Add `gem 'typus-i18n'` to your application's `Gemfile`, then run `bundle`.
- Set either the `#locale` of your admin user instance or `Typus.default_locale` to the language of your choice.


## How to contribute translations

There are two rake tasks to help you with translation:

1. `rake make_template LOCALE=xx` will generate an empty template file for your language (in `config/locales`).
2. `rake` will test if your YAML file is complete. Just run it, it will pick your file when it is in the correct place.

Details:

- fork the gem
- clone it locally and verify the tests are green, first
- create the translation file for your language and push it
- when the tests pass, create a pull request.
- if your pull request is accepted, win! Then, we would like to add you to the list of maintainers. That way you will get build notifications when the reference YAML file (the english version in the typus gem) changes and your translation needs to be updated.

Hint: some old translations are still available here: https://github.com/typus/typus-i18n/tree/v0.1.0, if you would like to start with them.