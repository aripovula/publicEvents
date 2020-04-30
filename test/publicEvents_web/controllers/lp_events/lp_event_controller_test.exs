defmodule PublicEventsWeb.LPEvents.LPEventControllerTest do
  use PublicEventsWeb.ConnCase

  alias PublicEvents.PubEvents

  @create_attrs %{description: "some description", end_time: ~N[2010-04-17 14:00:00], image: "some image", likes: 42, limitedParticipation: true, maxParticipants: 42, notes: "some notes", price: 42, start_time: ~N[2010-04-17 14:00:00], title: "some title", type: "some type", url: "some url", venue: "some venue"}
  @update_attrs %{description: "some updated description", end_time: ~N[2011-05-18 15:01:01], image: "some updated image", likes: 43, limitedParticipation: false, maxParticipants: 43, notes: "some updated notes", price: 43, start_time: ~N[2011-05-18 15:01:01], title: "some updated title", type: "some updated type", url: "some updated url", venue: "some updated venue"}
  @invalid_attrs %{description: nil, end_time: nil, image: nil, likes: nil, limitedParticipation: nil, maxParticipants: nil, notes: nil, price: nil, start_time: nil, title: nil, type: nil, url: nil, venue: nil}

  def fixture(:lp_event) do
    {:ok, lp_event} = PubEvents.create_lp_event(@create_attrs)
    lp_event
  end

  describe "index" do
    test "lists all lpevents", %{conn: conn} do
      conn = get(conn, Routes.lp_events_lp_event_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Lpevents"
    end
  end

  describe "new lp_event" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.lp_events_lp_event_path(conn, :new))
      assert html_response(conn, 200) =~ "New Lp event"
    end
  end

  describe "create lp_event" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.lp_events_lp_event_path(conn, :create), lp_event: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.lp_events_lp_event_path(conn, :show, id)

      conn = get(conn, Routes.lp_events_lp_event_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Lp event"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.lp_events_lp_event_path(conn, :create), lp_event: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Lp event"
    end
  end

  describe "edit lp_event" do
    setup [:create_lp_event]

    test "renders form for editing chosen lp_event", %{conn: conn, lp_event: lp_event} do
      conn = get(conn, Routes.lp_events_lp_event_path(conn, :edit, lp_event))
      assert html_response(conn, 200) =~ "Edit Lp event"
    end
  end

  describe "update lp_event" do
    setup [:create_lp_event]

    test "redirects when data is valid", %{conn: conn, lp_event: lp_event} do
      conn = put(conn, Routes.lp_events_lp_event_path(conn, :update, lp_event), lp_event: @update_attrs)
      assert redirected_to(conn) == Routes.lp_events_lp_event_path(conn, :show, lp_event)

      conn = get(conn, Routes.lp_events_lp_event_path(conn, :show, lp_event))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, lp_event: lp_event} do
      conn = put(conn, Routes.lp_events_lp_event_path(conn, :update, lp_event), lp_event: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Lp event"
    end
  end

  describe "delete lp_event" do
    setup [:create_lp_event]

    test "deletes chosen lp_event", %{conn: conn, lp_event: lp_event} do
      conn = delete(conn, Routes.lp_events_lp_event_path(conn, :delete, lp_event))
      assert redirected_to(conn) == Routes.lp_events_lp_event_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.lp_events_lp_event_path(conn, :show, lp_event))
      end
    end
  end

  defp create_lp_event(_) do
    lp_event = fixture(:lp_event)
    %{lp_event: lp_event}
  end
end
