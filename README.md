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

First make sure that your pi has support for the 1-wire protocol by editing `/boot/config.txt` and adding:

```
dtoverlay=w1-gpio
```

Then reboot it with `sudo reboot`.

Next get elixir running on the Pi. Run all these commands as root.

```
echo "deb http://packages.erlang-solutions.com/debian wheezy contrib" >> /etc/apt/sources.list
wget http://packages.erlang-solutions.com/debian/erlang_solutions.asc
sudo apt-key add erlang_solutions.asc && rm erlang_solutions.asc
sudo apt-get update
apt-get install -y --force-yes erlang-mini upstart htop git vim
mkdir /opt/elixir
curl  -L https://github.com/elixir-lang/elixir/releases/download/v1.2.3/Precompiled.zip -o /opt/elixir/precompiled.zip
cd /opt/elixir
unzip precompiled.zip
echo 'export PATH=/opt/elixir/bin:$PATH' >> /etc/bash.bashrc
export PATH=/opt/elixir/bin:$PATH
/opt/elixir/bin/mix local.hex --force
/opt/elixir/bin/mix local.rebar --force
```

Clone and setup this project

```
git clone https://github.com/mmmries/homebody.git /opt/homebody
cd /opt/homebody
mix deps.get
MIX_ENV=prod mix compile
cp /opt/homebody/homebody.conf /etc/init
start homebody
```
