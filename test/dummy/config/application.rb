require "action_controller/railtie"
require "action_mailer/railtie"
require "subdomain_locale/railtie"

module Dummy
  class Application < Rails::Application
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :en
    config.i18n.available_locales = :en, :ru, :uk
    config.subdomain_locale["ua"] = :uk

    config.secret_key_base = '-'
  end
end
