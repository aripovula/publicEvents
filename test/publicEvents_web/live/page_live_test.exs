defmodule PublicEventsWeb.PageLiveTest do
  use PublicEventsWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Upcoming events"
    assert render(page_live) =~ "Upcoming events"
  end
end
