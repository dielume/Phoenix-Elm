# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tuto,
  ecto_repos: [Tuto.Repo]

# Configures the endpoint
config :tuto, TutoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zPTDC17LNwvlqGyLXFhg4ocvAyDmWBr8Wt+vf1Ak9Wq5FFCER0pfYarlspfFpvKO",
  render_errors: [view: TutoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tuto.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :scrivener_html,
  routes_helper: MyApp.Router.Helpers,
  # If you use a single view style everywhere, you can configure it here. See View Styles below for more info.
  view_style: :bootstrap_v4

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
