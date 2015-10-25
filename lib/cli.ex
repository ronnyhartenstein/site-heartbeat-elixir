defmodule SiteHeartbeat.CLI do
  def main([file]) do
    Mix.Tasks.SiteTest.Bulk.run [file]
  end
end
