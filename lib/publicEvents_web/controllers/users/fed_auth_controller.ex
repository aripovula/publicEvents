defmodule PublicEventsWeb.FedAuthController do
  use PublicEventsWeb, :controller
  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do
    user_params = provider == "github" &&
    %{
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      nickname: auth.info.nickname,
      token: auth.credentials.token
    } ||
    %{}
    fullname = user_params.first_name && user_params.last_name && "#{user_params.first_name} #{user_params.last_name}"
    name = fullname && fullname || user_params.nickname || ""

    conn
    |> put_flash(:info, "Welcome #{name}!")
    |> put_session(:user_params, user_params)
    |> redirect(to: Routes.users_user_path(conn, :index))
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_session(:user_params, %{})
    |> redirect(to: Routes.users_user_path(conn, :index))
  end

end
