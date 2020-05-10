defmodule LPEventComponent do
  use Phoenix.LiveComponent

  def handle_event("say_hello", _value, socket) do
    val = (socket.assigns.content == "notConfirmed" && "confirmed") || "notConfirmed"
    {:noreply, assign(socket, content: val)}
  end

  def render(assigns) do
    ~L"""
    <div class="hero"><%= @content %></div>
    <a href="#" phx-click="say_hello" phx-target="<%= @myself %>">
      Toggle!
    </a>
    """
  end
end

# <%= inspect assigns %>
