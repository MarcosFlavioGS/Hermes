# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :hermes,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :hermes, HermesWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: HermesWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Hermes.PubSub,
  live_view: [signing_salt: "Hcl4kquQ"]

config :waffle,
  storage: Waffle.Storage.S3,
  bucket: {:system, "BUCKET"},
  asset_host: {:system, "ACCESS_HOST"}

config :ex_aws,
  json_codec: Jason,
  access_key_id: [{:system, "AWS_ACCESS_KEY"}, {:awscli, "default", 30}, :instance_role],
  secret_access_key: [{:awscli, "default", 30}, :instance_role],
  region: {:system, "AWS_REGION"}

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :hermes, Hermes.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
