defmodule SiteHeartbeat.CLI do
  alias Mix.Tasks.SiteTest.Bulk
  def main([file]) do
    Bulk.run [file]
  end
end
