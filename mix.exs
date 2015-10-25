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
      {:httpoison, "~> 0.7.2"},
      {:parallel, "~> 0.0.0"},
      {:exrm, "~> 0.18.1"}
      #{:codepagex, "~> 0.1.1"}
    ]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end


  defp escript_config do
    [ main_module: SiteHeartbeat.CLI ]
  end

end
