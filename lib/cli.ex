defmodule SiteHeartbeat.CLI do
  def main(argv) do
    SiteHeartbeat.Tasks.Bulk.run "config/hosts.txt"
  end
end
