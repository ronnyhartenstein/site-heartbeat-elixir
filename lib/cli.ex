defmodule SiteHeartbeat.CLI do
  def main(_argv) do
    Mix.Tasks.SiteTest.Bulk.run ["config/hosts.txt"]
  end
end
