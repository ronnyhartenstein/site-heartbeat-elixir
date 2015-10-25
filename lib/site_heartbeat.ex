defmodule SiteHeartbeat do
  use HTTPotion.Base
  require Logger

  defstruct raw: "", domain: "", title: "", error: []

  def process_response_body(body) do
    body_str = body |> IO.iodata_to_binary
    IO.puts String.slice body_str, 1..200
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
