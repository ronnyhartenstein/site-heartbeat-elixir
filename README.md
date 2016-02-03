# SiteHeartbeat

Checks for a bunch of domains their HTTP status code (200) and the `<title>`.

Project for blog post [Coding Kata: Site Heartbeat in Elixir and Golang](http://blog.rh-flow.de/2016/02/02/coding-kata-site-heartbeat-in-elixir-and-golang/).

Uses https://github.com/edgurgel/httpoison


# Deployment

- Build it as `escript` locally,

    mix escript.build

- `scp` the `site_heartbeat` to target system (e.g. `~/site-heartbeat`).
- Maintain a valuable `hosts.txt`.
- Run it for test

    ./site-heartbeat/site_heartbeat hosts.txt

- Put it into the crontab - running hourly

    5 * * * * cd /var/www/vhosts/rh-flow.de/site-heartbeat; ./site_heartbeat hosts.txt

- Add locales to the cronjob, otherwise "the VM is running with native name encoding of latin1 which may cause Elixir to malfunction as it expects utf8"

    LANG="de_DE.utf8"
    LANGUAGE="de_DE:"
    LC_ALL=de_DE.UTF-8
