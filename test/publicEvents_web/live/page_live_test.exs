defmodule PublicEventsWeb.PageLiveTest do
  use PublicEventsWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/page")
    assert disconnected_html =~ "Page is pages!"
    assert render(page_live) =~ "Page is pages!"
  end
end
