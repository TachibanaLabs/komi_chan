defmodule KomiChan.Repo do
  use Ecto.Repo,
    otp_app: :komi_chan,
    adapter: Ecto.Adapters.Postgres
end
