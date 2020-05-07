use Mix.Config

# Configure your database
config :publicEvents, PublicEvents.Repo,
  username: "ula",
  password: "",
  database: "publicEvents_systest",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# We don't run a server during test, but we need it for systemtest!
config :publicEvents, PublicEventsWeb.Endpoint,
  http: [port: 5000],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn
