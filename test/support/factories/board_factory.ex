defmodule KomiChan.BoardFactory do
  @moduledoc """
  Factories for Board model
  """

  defmacro __using__(_opts) do
    quote do
      def board_factory do
        %KomiChan.Repositories.Board{name: "t", description: "test", rules: "none"}
      end
    end
  end
end
