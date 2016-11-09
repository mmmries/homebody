defmodule Blinky do
  def keep_sleeping_bounds do
    Application.get_env(Blinky, :wakeup_bounds, { {5,30,0}, {7,19,59} })
  end

  def timezone do
    Application.get_env(Blinky, :timezone, "US/Mountain")
  end

  def wakeup_bounds do
    Application.get_env(Blinky, :wakeup_bounds, { {7,20,0}, {8,30,0} })
  end
end
