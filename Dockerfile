FROM hqmq/resin-elixir:1.2.4.0
COPY . /app
WORKDIR /app
RUN mix deps get && mix compile
CMD elixir --name "homebody@$(hostname).local" --cookie pi -S mix run --no-halt --no-deps-check
