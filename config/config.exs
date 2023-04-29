# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :scan,
  ecto_repos: [Scan.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :scan, ScanWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: ScanWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Scan.PubSub,
  live_view: [signing_salt: "5AmWgT0w"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :scan, Scan.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :scan, ScanWeb.Auth.Guardian,
  issuer: "scan",
  secret_key: "SWJ5TkptJ8/18CT9V3LLkDOjugmLx4UoHi1j8L8lV8CUT8LSv6s81d9VllpBUk3/"

# Use Guardian DB for storing tokens in Phoenix
config :guardian, Guardian.DB,
  repo: Scan.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

config :scan, Scan.Mailer,
  adapter: Swoosh.Adapters.Sendinblue,
  api_key:
    "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"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
