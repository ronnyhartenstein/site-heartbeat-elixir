# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config


config :logger, :console,
  level: :error #,
  # compile_time_purge_level: :debug

config :site_heartbeat, email: "siteheartbeat@rh-flow.de"

# config :mailer,
#   templates: "priv/templates",
#   server: "mail.rh-flow.de",
#   username: "ronny@rh-flow.de",
#   password: "",
#   ssl: true
