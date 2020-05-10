defmodule PublicEventsWeb.LPEventLiveTest do
  use PublicEventsWeb.ConnCase
  alias PublicEvents.PubEvents

  import Phoenix.LiveViewTest

  #  anchor links navigating to other pages are tested as part of e2e (Cypress) testing

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Upcoming events"
    assert render(page_live) =~ "Upcoming events"
  end

  test "next and prev pagination buttons work", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "page 1"
    assert render(view) =~ "page 1"
    anchorLink = element(view, "#nextAncr a:first-child()", "next")
    render_click(anchorLink)
    assert render(view) =~ "page 2"
    anchorLink = element(view, "#nextAncr a:first-child()", "next")
    render_click(anchorLink)
    assert render(view) =~ "page 3"
    anchorLink = element(view, "#prevAncr a:first-child()", "prev")
    render_click(anchorLink)
    assert render(view) =~ "page 2"
  end

  test "numeric pagination links work", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "page 1"
    assert render(view) =~ "page 1"
    anchorLink = element(view, "#pageAncr a:first-child()", "3")
    render_click(anchorLink)
    assert render(view) =~ "page 3"
  end

  @create_attrs %{
    title: "some title",
    description: "some description",
    end_time: ~N[2010-04-17 14:00:00],
    image: "some image",
    likes: 42,
    limitedParticipation: true,
    maxParticipants: 42,
    notes: "some notes",
    price: 42,
    start_time: ~N[2010-04-17 14:00:00],
    type: "some type",
    url: "some url",
    venue: "some venue"
  }
  @update_attrs %{
    title: "some updated title",
    description: "some updated description",
    end_time: ~N[2011-05-18 15:01:01],
    image: "some updated image",
    likes: 43,
    limitedParticipation: false,
    maxParticipants: 43,
    notes: "some updated notes",
    price: 43,
    start_time: ~N[2011-05-18 15:01:01],
    type: "some updated type",
    url: "some updated url",
    venue: "some updated venue"
  }

  def fixture(:lp_event) do
    {:ok, lp_event} = PubEvents.create_lp_event(@create_attrs)
    {:ok, _lp_event} = PubEvents.create_lp_event(@update_attrs)
    lp_event
  end

  describe "add events and test navigation" do
    setup [:create_lp_event]

    test "event title is displayed on table", %{conn: conn} do
      {:ok, view, disconnected_html} = live(conn, "/")
      assert disconnected_html =~ "page 1"
      assert render(view) =~ "page 1"
      assert render(view) =~ "some title"
      assert render(view) =~ "some updated title"
    end
  end

  defp create_lp_event(_) do
    lp_event = fixture(:lp_event)
    %{lp_event: lp_event}
  end
end
