defmodule Rantclub.Repo do
  use Ecto.Repo,
    otp_app: :rantclub,
    adapter: Ecto.Adapters.Postgres
end
