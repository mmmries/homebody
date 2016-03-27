# Homebody

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add homebody to your list of dependencies in `mix.exs`:

        def deps do
          [{:homebody, "~> 0.0.1"}]
        end

  2. Ensure homebody is started before your application:

        def application do
          [applications: [:homebody]]
        end

## Up and Running

* Get Elixir running on the pi
* Clone this repo to `/opt/homebody`
* `cp /opt/homebody/homebody.conf /etc/init`
* `start homebody`
