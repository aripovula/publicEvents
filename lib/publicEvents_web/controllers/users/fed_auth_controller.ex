defmodule PublicEventsWeb.Users.FedAuthController do
  use PublicEventsWeb, :controller
  plug Ueberauth

  # alias PublicEvents.Accounts
  # alias PublicEvents.Accounts.User

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do
    user_params = provider == "github" &&
    %{
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      nickname: auth.info.nickname,
      token: auth.credentials.token
    } ||
    %{email: "abc"}
    IO.inspect "+++++++ auth +++++"
    IO.inspect auth
    IO.inspect "+++++++ params +++++"
    IO.inspect user_params
    IO.inspect "+++++++ provider +++++"
    IO.inspect provider
    IO.inspect "+++++++  +++++"
    conn
    |> put_flash(:info, "Welcome!")
    |> put_session(:token, user_params.token)
    |> redirect(to: Routes.users_user_path(conn, :index))
  end

end
