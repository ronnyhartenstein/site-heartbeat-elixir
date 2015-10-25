defmodule SiteHeartbeat.Notifier do
  require Logger

  @email Application.get_env(:notifier, :email)

  def errors(%{title: title, domain: domain, error: errors}) do
    #Logger.error "errors #{errors}"
    send "#{domain} (#{title}): #{errors}"
  end

  def domain_unreachable(domain) do
    send "Domain #{domain} not reachable"
  end

  def title_wrong(domain, title) do
    send "Title '#{title}' for domain #{domain} is wrong!"
  end

  defp send(msg) do
    # Mailer - gen_smtp makes trouble
    # email = Mailer.compose_email(@email, @email,
    #             "Site-Heartbeat: #{domain} not reachable",
    #             "not_reachable",
    #             [domain: domain])
    # Logger.debug "Mailer email #{email}"
    # response = Mailer.send(email)
    # Logger.debug "Mailer response #{response}"

    IO.puts :stderr, msg

  end
end
