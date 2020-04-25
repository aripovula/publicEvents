defmodule PublicEvents.Repo do
  use Ecto.Repo,
    otp_app: :publicEvents,
    adapter: Ecto.Adapters.Postgres
end
