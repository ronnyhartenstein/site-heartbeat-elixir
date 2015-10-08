defmodule Mix.Tasks.SiteTest.Bulk do
  use Mix.Task
  import Logger

  #@sites Application.get_env(:sites, :list)
  @shortdoc "test of all configured sites"

  def run([file]) when is_binary(file) do
    :ibrowse.start
    Logger.debug "file #{file} .."
    File.stream!(file)
    |> Stream.map(&remove_newline/1)
    |> Enum.map(&proc_domain/1)
  end

  defp remove_newline(domain) do
    String.slice domain, 0..-2
  end

  defp proc_domain(domain) do
    try do
      Logger.debug "check #{domain}"
      %{body: stat} = SiteHeartbeat.get(domain)
      Logger.debug "status #{stat}"
    rescue
      error ->
        Logger.debug "#{domain} -> #{error.message}"
        SiteHeartbeat.Notifier.send(domain)
    end
  end
end
