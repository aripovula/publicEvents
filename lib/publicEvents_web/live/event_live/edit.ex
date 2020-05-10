defmodule PublicEventsWeb.LPEventLive.Edit do
  use Phoenix.LiveView

  alias PublicEvents.PubEvents
  alias PublicEventsWeb.LPEventLiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    lp_event = PubEvents.get_lp_event!(id)

    {:noreply,
     assign(socket, %{
       lp_event: lp_event,
       changeset: PubEvents.change_lp_event(lp_event)
     })}
  end

  def render(assigns), do: LPEventLiveView.render("edit.html", assigns)

  def handle_event("validate", %{"lp_event" => params}, socket) do
    changeset =
      socket.assigns.lp_event
      |> PubEvents.change_lp_event(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"lp_event" => lp_event_params}, socket) do
    case PubEvents.update_lp_event(socket.assigns.lp_event, lp_event_params) do
      {:ok, lp_event} ->
        {:noreply, push_redirect(socket, to: "/event/#{lp_event.id}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
