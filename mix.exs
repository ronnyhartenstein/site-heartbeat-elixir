defmodule SiteHeartbeat.Mixfile do
  use Mix.Project

  def project do
    [app: :site_heartbeat,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.2"},
      {:httpotion, "~> 2.1.0"},
      #{:exsync, "~> 0.1", only: :dev},
      {:mailer, "~> 0.5.1"},
      {:timex, "~> 0.19.5"},
      {:tzdata, "~> 0.5.4"}
    ]
  end

  def application do
    [applications: [:httpotion, :exsync, :tzdata]]
    # Application dependency auto-starts it, otherwise: HTTPotion.start
  end

end
