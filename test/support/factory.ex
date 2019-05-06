defmodule KomiChan.Factory do
  @moduledoc """
  Main module for factories for ExMachina
  """

  use ExMachina
  use KomiChan.MementoStrategy
  use KomiChan.BoardFactory
end
