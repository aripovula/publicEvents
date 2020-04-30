defmodule PublicEventsWeb.Plugs.CheckUser do
  import Plug.Conn
  # import Phoenix.Controller

  # alias PublicEvents.Accounts
  # alias PublicEvents.Accounts.User

  def init(_opts) do
  end

  def call(conn, _opts) do
    assign(conn, :user_params, get_session(conn, :user_params))
  end
end
