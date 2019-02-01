defmodule KomiChan.Model do
  defmodule Thread do
    defstruct [:id, :message, :created_at, :updated_at]

    def new(message) do
      %Thread{message: message}
    end
  end
end
