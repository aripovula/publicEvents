defmodule PublicEventsWeb.LPEventLive.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias PublicEventsWeb.LPEventLive
  alias PublicEvents.PubEvents
  alias PublicEventsWeb.Router.Helpers, as: Routes
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    ~L"""
    <h1>Event Details</h1>

    <ul>
      <li>
        <strong>Title:</strong>
        <%= @lp_event.title %>
      </li>

      <li>
        <strong>Description:</strong>
        <%= @lp_event.description %>
      </li>

      <li>
        <strong>Price:</strong>
        <%= @lp_event.price %>
      </li>

      <li>
        <strong>Likes:</strong>
        <%= @lp_event.likes %>
      </li>

      <li>
        <strong>Start time:</strong>
        <%= @lp_event.start_time %>
      </li>

      <li>
        <strong>End time:</strong>
        <%= @lp_event.end_time %>
      </li>

      <li>
        <strong>Limitedparticipation:</strong>
        <%= @lp_event.limitedParticipation %>
      </li>

      <li>
        <strong>Maxparticipants:</strong>
        <%= @lp_event.maxParticipants %>
      </li>

      <li>
        <strong>Image:</strong>
        <%= @lp_event.image %>
      </li>

      <li>
        <strong>Url:</strong>
        <%= @lp_event.url %>
      </li>

      <li>
        <strong>Venue:</strong>
        <%= @lp_event.venue %>
      </li>

      <li>
        <strong>Notes:</strong>
        <%= @lp_event.notes %>
      </li>

      <li>
        <strong>Type:</strong>
        <%= @lp_event.type %>
      </li>

    </ul>
    <span><%= link "Edit", to: Routes.live_path(@socket, LPEventLive.Edit, @lp_event) %></span>
    <span><%= link "Back", to: Routes.live_path(@socket, LPEventLive) %></span>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    # if connected?(socket), do: LPEventLive.subscribe(id)
    case PubEvents.get_lp_event(id) do
      nil ->
        {:noreply, push_redirect(socket, to: "/event/notfound")}

      lp_event ->
        {:noreply, assign(socket, lp_event: lp_event)}
    end
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    assign(socket, lp_event: PubEvents.get_lp_event!(id))
  end

  def handle_info({PubEvents, [:lp_event, :updated], _}, socket) do
    {:noreply, fetch(socket)}
  end
end
