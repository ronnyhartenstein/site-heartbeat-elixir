defmodule SiteHeartbeat.CLI do
  def main(argv) do
    SiteHeartbeat.Tasks.Bulk.run true
  end
end
