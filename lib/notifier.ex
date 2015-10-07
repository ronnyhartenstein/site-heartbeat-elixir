defmodule SiteHeartbeat.Notifier do
  import Logger

  @email Application.get_env(:notifier, :email)

  def send(domain) do
    # email = Mailer.compose_email(@email, @email,
    #             "Site-Heartbeat: #{domain} not reachable",
    #             "not_reachable",
    #             [domain: domain])
    # Logger.debug "Mailer email #{email}"
    # response = Mailer.send(email)
    # Logger.debug "Mailer response #{response}"
    IO.puts :stderr, "Domain #{domain} not reachable"
  end
end
