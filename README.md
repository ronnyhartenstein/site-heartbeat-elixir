# SiteHeartbeat

Checks for a bunch of domains their HTTP status code (200) and the `<title>`.

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
