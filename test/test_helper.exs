ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)
{:ok, _} = Application.ensure_all_started(:ex_machina)
