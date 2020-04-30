defmodule PublicEventsWeb.LPEvents.LPEventController do
  use PublicEventsWeb, :controller

  alias PublicEvents.PubEvents
  alias PublicEvents.PubEvents.LPEvent

  def index(conn, _params) do
    lpevents = PubEvents.list_lpevents()
    render(conn, "index.html", lpevents: lpevents)
  end

  def new(conn, _params) do
    changeset = PubEvents.change_lp_event(%LPEvent{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lp_event" => lp_event_params}) do
    case PubEvents.create_lp_event(lp_event_params) do
      {:ok, lp_event} ->
        conn
        |> put_flash(:info, "Lp event created successfully.")
        |> redirect(to: Routes.lp_events_lp_event_path(conn, :show, lp_event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    lp_event = PubEvents.get_lp_event!(id)
    render(conn, "show.html", lp_event: lp_event)
  end

  def edit(conn, %{"id" => id}) do
    lp_event = PubEvents.get_lp_event!(id)
    changeset = PubEvents.change_lp_event(lp_event)
    render(conn, "edit.html", lp_event: lp_event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "lp_event" => lp_event_params}) do
    lp_event = PubEvents.get_lp_event!(id)

    case PubEvents.update_lp_event(lp_event, lp_event_params) do
      {:ok, lp_event} ->
        conn
        |> put_flash(:info, "Lp event updated successfully.")
        |> redirect(to: Routes.lp_events_lp_event_path(conn, :show, lp_event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", lp_event: lp_event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    lp_event = PubEvents.get_lp_event!(id)
    {:ok, _lp_event} = PubEvents.delete_lp_event(lp_event)

    conn
    |> put_flash(:info, "Lp event deleted successfully.")
    |> redirect(to: Routes.lp_events_lp_event_path(conn, :index))
  end
end
