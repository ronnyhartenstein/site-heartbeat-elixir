defmodule SiteHeartbeat.Mixfile do
  use Mix.Project

  def project do
    [app: :site_heartbeat,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: escript_config,
     deps: deps]
  end

  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.2"},
      {:httpotion, "~> 2.1.0"},
      {:exsync, "~> 0.1", only: :dev},
      {:mailer, github: "antp/mailer"},
      {:timex, github: "bitwalker/timex"}
      #{:tzdata, github: "lau/tzdata"}
    ]
  end

  def application do
    [applications: [:httpotion, :exsync, :tzdata]]
    # Application dependency auto-starts it, otherwise: HTTPotion.start
  end


  defp escript_config do
    [ main_module: SiteHeartbeat.CLI ]
  end

end
