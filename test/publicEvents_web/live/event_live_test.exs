defmodule PublicEventsWeb.LPEventLiveTest do
  use PublicEventsWeb.ConnCase
  alias PublicEvents.PubEvents
  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Upcoming events"
    assert render(page_live) =~ "Upcoming events"
  end

  test "goes to next page", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "page 1"
    assert render(view) =~ "page 1"
    anchorLink = element(view, "#nextAncr a:first-child()", "next")
    render_click(anchorLink)
    assert render(view) =~ "page 2"
  end

  test "goes to page 3", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "page 1"
    assert render(view) =~ "page 1"
    anchorLink = element(view, "#pageAncr a:first-child()", "3")
    render_click(anchorLink)
    assert render(view) =~ "page 3"
  end

  # PREP work for testing handle_info/handle_event
  # @create_attrs %{description: "some description", end_time: ~N[2010-04-17 14:00:00], image: "some image", likes: 42, limitedParticipation: true, maxParticipants: 42, notes: "some notes", price: 42, start_time: ~N[2010-04-17 14:00:00], title: "some title", type: "some type", url: "some url", venue: "some venue"}
  # @update_attrs %{description: "some updated description", end_time: ~N[2011-05-18 15:01:01], image: "some updated image", likes: 43, limitedParticipation: false, maxParticipants: 43, notes: "some updated notes", price: 43, start_time: ~N[2011-05-18 15:01:01], title: "some updated title", type: "some updated type", url: "some updated url", venue: "some updated venue"}
  # @invalid_attrs %{description: nil, end_time: nil, image: nil, likes: nil, limitedParticipation: nil, maxParticipants: nil, notes: nil, price: nil, start_time: nil, title: nil, type: nil, url: nil, venue: nil}

  # def fixture(:lp_event) do
  #   {:ok, lp_event} = PubEvents.create_lp_event(@create_attrs)
  #   lp_event
  # end

  # describe "delete" do
  #   setup [:create_lp_event]
  #   test "handle_info/2", %{conn: conn} do
  #     {:ok, view, disconnected_html} = live(conn, "/")
  #     assert disconnected_html =~ "Count: 0"
  #     assert render(view) =~ "Count: 0"
  #     send(view.pid, %{payload: %{ val: 1 }})
  #     assert render(view) =~ "Count: 1"
  #   end
  # end

  # defp create_lp_event(_) do
  #   lp_event = fixture(:lp_event)
  #   %{lp_event: lp_event}
  # end

end
