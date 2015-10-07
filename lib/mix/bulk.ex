defmodule Mix.Tasks.SiteTest.Bulk do
  use Mix.Task
  import Logger

  @sites Application.get_env(:sites, :list)
  @shortdoc "test of all configured sites"

  def run(_) do
    :ibrowse.start
    Enum.map @sites, &proc_domain/1
  end

  def proc_domain(domain) do
    try do
      Logger.debug "check #{domain}"
      %{body: stat} = SiteHeartbeat.get(domain)
      Logger.debug "status #{stat}"
    rescue
      error ->
        Logger.warn "#{domain} -> #{error.message}"
        SiteHeartbeat.Notifier.send(domain)
    end
  end
end
