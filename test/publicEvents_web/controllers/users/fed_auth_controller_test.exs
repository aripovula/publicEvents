defmodule PublicEventsWeb.FedAuthControllerTest do
  use PublicEventsWeb.ConnCase

  # this tests two endpoints - :request and :callback - ueberauth request calls back :callback endpoint
  describe "sign in user" do
    test "redirects to github oAuth when login is successful", %{conn: conn} do
      conn = get(conn, Routes.fed_auth_path(conn, :request, "github"))

      assert String.contains?(redirected_to(conn), "https://github.com/login/oauth/authorize?client_id=")
      assert String.contains?(redirected_to(conn), "callback&response_type=code&scope=user")

      conn = get(conn, Routes.users_user_path(conn, :index))
      assert html_response(conn, 200) =~ "Registered users"
    end
  end
end
