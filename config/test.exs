import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hermes, HermesWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "+OzqCnTwKwKuI+3fmDvDT8uqJpwUm4pj1vjscz30IE49Z1N/+rNUcLqAi/N3Ck/t",
  server: false

# In test we don't send emails
config :hermes, Hermes.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
