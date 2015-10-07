# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :sites, list: [
  "blog.rh-flow.de",
  "hellmigs-hundeladen.de"
]

config :notifier, email: "siteheartbeat@rh-flow.de"

config :mailer,
  templates: "priv/templates",
  server: "mail.rh-flow.de",
  username: "ronny@rh-flow.de",
  password: "insane42",
  ssl: true
