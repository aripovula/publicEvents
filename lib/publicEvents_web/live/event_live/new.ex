defmodule PublicEventsWeb.LPEventLive.New do
  use Phoenix.LiveView

  alias PublicEvents.PubEvents
  alias PublicEvents.PubEvents.LPEvent
  alias PublicEventsWeb.LPEventLiveView

  def mount(_params, _session, socket) do
    changeset = PubEvents.change_lp_event(%LPEvent{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns), do: Phoenix.View.render(LPEventLiveView, "new.html", assigns)

  def handle_event("validate", %{"lp_event" => lp_event_params}, socket) do
    changeset =
      %LPEvent{}
      |> PubEvents.change_lp_event(lp_event_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"lp_event" => lp_event_params}, socket) do
    case PubEvents.create_lp_event(lp_event_params) do
      {:ok, lp_event} ->
        {:noreply, push_redirect(socket, to: "/event/#{lp_event.id}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
