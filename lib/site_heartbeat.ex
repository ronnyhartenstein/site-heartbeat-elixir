defmodule SiteHeartbeat do
  require Logger

  defstruct raw: "", domain: "", title: "", error: []

  def get(domain) do
    case HTTPoison.get! "http://" <> domain do
      res = %HTTPoison.Response{status_code: 200, body: body} ->
        #IO.inspect res
        #File.write "dump_#{domain}.txt", body
        %{body: process_response_body(body), status_code: 200}
      %HTTPoison.Response{status_code: 404} ->
        %{body: {:error, ""}, status_code: 404}
      %HTTPoison.Error{reason: reason} ->
        %{body: {:error, reason}, status_code: 500}
    end
  end

  def process_response_body(body) do
    body_str = body |> IO.chardata_to_string  #IO.iodata_to_binary
    #IO.puts String.slice body_str, 1..200
    case Regex.run(~r/<title>(.*?)<\/title>/, body_str) do
      [_, title] when is_binary(title) ->
        Logger.debug "title: #{title}"
        {:ok, title}
      nil ->
        Logger.warn "title not found"
        {:error, ""}
    end
  end
end
