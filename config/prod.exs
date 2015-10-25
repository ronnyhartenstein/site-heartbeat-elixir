# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# Do not print debug messages in production
config :logger,
  level: :info,
  compile_time_purge_level: :info

# Send to this email
#config :notifier, email: "siteheartbeat@rh-flow.de"

# config :mailer,
#   templates: "priv/templates",
#   server: "mail.rh-flow.de",
#   username: "ronny@rh-flow.de",
#   password: "",
#   ssl: true
