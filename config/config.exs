# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :publicEvents,
  ecto_repos: [PublicEvents.Repo]

# Configures the endpoint
config :publicEvents, PublicEventsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0SLTcbD7IPbgRF8KxW/EobUZGFYVwTpqh/ZH6PCN5ipMPRuD4e7IlS/mn52wYpbn",
  render_errors: [view: PublicEventsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PublicEvents.PubSub,
  live_view: [signing_salt: "A1Jd2l3H"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

# config :ueberauth, Ueberauth.Strategy.Google.OAuth,
#   client_id: System.get_env("GOOGLE_CLIENT_ID"),
#   client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

config :ueberauth, Ueberauth,
  providers: [
    # google: { Ueberauth.Strategy.Google, [default_scope: "email profile"] },
    github: {Ueberauth.Strategy.Github, [default_scope: "user:email"]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
