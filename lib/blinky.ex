defmodule Blinky do
  def keep_sleeping_bounds do
    Application.get_env(Blinky, :keep_sleeping_bounds, { {5,30,0}, {7,19,59} })
  end

  def keep_sleeping_pin do
    Application.get_env(Blinky, :keep_sleeping_pin)
  end

  def start_application? do
    Application.get_env(Blinky, :wakeup_pin) != nil
  end

  def timezone do
    Application.get_env(Blinky, :timezone, "US/Mountain")
  end

  def wakeup_bounds do
    Application.get_env(Blinky, :wakeup_bounds, { {7,20,0}, {8,30,0} })
  end

  def wakeup_pin do
    Application.get_env(Blinky, :wakeup_pin)
  end
end
