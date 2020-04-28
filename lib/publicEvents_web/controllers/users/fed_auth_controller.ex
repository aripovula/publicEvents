defmodule PublicEventsWeb.Users.FedAuthController do
  use PublicEventsWeb, :controller
  plug Ueberauth

  # alias PublicEvents.Accounts
  # alias PublicEvents.Accounts.User

  def callback(conn, params) do
    IO.inspect "+++++++ conn.assigns +++++"
    IO.inspect conn.assigns
    IO.inspect "+++++++ params +++++"
    IO.inspect params
    IO.inspect "+++++++  +++++"

  end

end
