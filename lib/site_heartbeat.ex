defmodule SiteHeartbeat do
  use HTTPotion.Base
  require Logger

  defstruct raw: "", domain: "", title: "", error: []

  def process_url(url) do
    # macht ja komplett HTTPotion schon mit sich!
    Logger.error "WWOOOOT"
    url = url
    |> prepend_http
    |> append_trailing_slash
    Logger.error "URL: #{url}"
    url
  end

  defp prepend_http(url) do
    if ! url =~ ~r"^https?://" do
      Logger.debug "prepend http"
      "http://" <> url
    else
      Logger.debug "no prepend http"
      url
    end
  end

  defp append_trailing_slash(url) do
    if ! url =~ ~r"/$" do
      Logger.debug "append /"
      url <> "/"
    else
      Logger.debug "no append"
      url
    end
  end

  #def process_request_headers(headers) do
  #  Dict.put headers, :"User-Agent", "github-potion"
  #end

  def process_response_body(body) do
    body_str = body |> IO.iodata_to_binary
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
