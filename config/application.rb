require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# カスタムフォームビルダーを読み込む
require_relative "../app/helpers/custom_form_builder"

module PotepanShare
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # デフォルトのロケールを日本語に設定
    config.i18n.default_locale = :ja

    # Disable field_with_errors wrapper
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag.html_safe }

    # カスタムフォームビルダーを使用
    config.action_view.default_form_builder = CustomFormBuilder
  end
end
