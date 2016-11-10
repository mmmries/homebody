# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :homebody, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:homebody, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

# Whichever node you want to collect and report the measurements needs to setup the following config
if System.get_env("homebody_reporting_url") do
  config :homebody, :reporting,
    url: System.get_env("homebody_reporting_url")
end
if System.get_env("homebody_sensor_aliases") do
  {aliases, []} = System.get_env("homebody_sensor_aliases") |> Code.eval_string
  config :homebody, :sensor_aliases, aliases
end

if System.get_env("blinky_wakeup_pin") do
  config Blinky,
    timezone: System.get_env("timezone"),
    keep_sleeping_bounds: System.get_env("keep_sleeping_bounds") |> Code.eval_string |> elem(0),
    wakeup_bounds: System.get_env("wakeup_bounds") |> Code.eval_string |> elem(0),
    keep_sleeping_pin: System.get_env("blinky_sleeping_pin") |> Code.eval_string |> elem(0),
    wakeup_pin: System.get_env("blinky_wakeup_pin") |> Code.eval_string |> elem(0)
end
