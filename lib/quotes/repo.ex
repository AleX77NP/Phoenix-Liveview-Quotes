defmodule Quotes.Repo do
  use Ecto.Repo,
    otp_app: :quotes,
    adapter: Ecto.Adapters.Postgres
end
