defmodule Mix.Tasks.SiteTest.Single do
  use Mix.Task
  require Logger
  alias SiteHeartbeat.Notifier

  @shortdoc "test of a single site (Param: 'domain.tld')"

  def run([domain]) when is_binary(domain) do
    :ibrowse.start
    Application.load(:tzdata)

    try do
      Logger.debug "check #{domain}"
      %{body: stat} = SiteHeartbeat.get(domain)
      Logger.debug "status #{stat}"
    rescue
      error ->
        Logger.debug "#{domain} -> #{error.message}"
        Notifier.send(domain)
    end
  end
end
