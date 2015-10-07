defmodule SiteHeartbeat do
  use HTTPotion.Base
  import Logger

  def process_url(url) do
    "http://" <> url <> "/"
  end

  #def process_request_headers(headers) do
  #  Dict.put headers, :"User-Agent", "github-potion"
  #end

  def process_response_body(body) do
    body_str = body |> IO.iodata_to_binary
    case Regex.run(~r/<title>(.*?)<\/title>/, body_str) do
      [_, title] when is_binary(title) -> true
      nil -> false
    end
  end
end
