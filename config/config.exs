# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :quotes,
  ecto_repos: [Quotes.Repo]

# Configures the endpoint
config :quotes, QuotesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Farw1WFoqs8S2yutIDU/ZxLNdSZkuDgcRYrxd+YqBlbSkN6AD1BvaphiAzJCtIAu",
  render_errors: [view: QuotesWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Quotes.PubSub,
  live_view: [signing_salt: "Lx0Oz+fO"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
