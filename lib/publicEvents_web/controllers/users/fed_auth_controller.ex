defmodule PublicEventsWeb.FedAuthController do
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
    %{}
    # IO.inspect "+++++++ auth +++++"
    # IO.inspect auth
    # IO.inspect "+++++++ params +++++"
    # IO.inspect user_params
    # IO.inspect "+++++++ provider +++++"
    # IO.inspect provider
    # IO.inspect "+++++++  +++++"
    fullname = user_params.first_name && user_params.last_name && "#{user_params.first_name} #{user_params.last_name}"
    name = fullname && fullname || user_params.nickname || ""

    conn
    |> put_flash(:info, "Welcome #{name}!")
    |> put_session(:user_params, user_params)
    |> redirect(to: Routes.users_user_path(conn, :index))
  end

  def signout(conn, _params) do
    conn
    # |> IO.inspect(label: "Before-+++-", value: get_session(conn, :user_params))
    |> configure_session(drop: true)
    |> put_session(:user_params, %{})
    # |> IO.inspect(label: "After-+++-", value: get_session(conn, :user_params))
    |> redirect(to: Routes.users_user_path(conn, :index))
  end

  # |> assign(:user_params, %{})
end
