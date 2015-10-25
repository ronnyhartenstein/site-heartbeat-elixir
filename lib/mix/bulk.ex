defmodule Mix.Tasks.SiteTest.Bulk do
  use Mix.Task
  require Logger

  #@sites Application.get_env(:sites, :list)
  @shortdoc "test of all configured sites"

  def run([file]) when is_binary(file) do
    HTTPoison.start
    Logger.debug "file #{file} .."
    File.stream!(file)
    |> Stream.map(&to_struct/1)
    #|> Stream.map(&remove_newline/1)
    |> Stream.filter(&is_active_domain/1)
    |> Parallel.map(&proc_domain/1)

    #Logger.debug "stop service"
    #HTTPoison.stop
  end

  defp to_struct(raw) do
    [domain, title] = String.split remove_newline(raw), ": ", parts: 2, trim: true
    %SiteHeartbeat{raw: raw, domain: domain, title: title}
  end

  defp remove_newline(row) do
    String.slice row, 0..-2
  end

  defp is_active_domain(%{domain: domain}) do
    String.at(domain, 0) != "#"
  end

  defp proc_domain(%{domain: domain} = row) do
    Logger.debug "check domain #{domain}"
    %{body: {stat, curr_title}, status_code: status_code} = SiteHeartbeat.get(domain)
    Logger.debug "status #{stat}"
    row
    |> check_error(stat, curr_title)
    |> check_title(curr_title)
    |> check_status_code(status_code)
    |> notify_on_errors
  end

  defp check_error(%{domain: domain} = row, :error, error) do
    Logger.debug "#{domain} -> error #{error}"
    %{row | error: ["error happens" | row.error]}
  end
  defp check_error(row,_,_), do: row

  defp check_title(%{domain: domain, title: title} = row, curr_title) when curr_title != title do
    Logger.debug "#{domain} -> '#{curr_title}' - should be '#{title}'"
    #SiteHeartbeat.Notifier.title_wrong(domain, title)
    %{row | error: ["title wrong" | row.error]}
  end
  defp check_title(row,_), do: row

  defp check_status_code(%{domain: domain} = row, status_code) when status_code != 200 do
    Logger.debug "#{domain} -> status #{status_code} - should be 200"
    %{row | error: ["status code" | row.error]}
  end
  defp check_status_code(row, _), do: row


  defp notify_on_errors(%{error: errors} = row) when errors != [] do
    SiteHeartbeat.Notifier.errors(row)
  end
  defp notify_on_errors(_), do: nil
end
