defmodule TestComponent do
  use Phoenix.LiveComponent

  def handle_event("say_hello", _value, socket) do
    val = socket.assigns.content == "ABC1234" && "ABCtest" || "ABC1234"
    {:noreply, assign(socket, content: val)}
  end

  def render(assigns) do
    ~L"""
    <div class="hero">a-<%= @content %></div>
    <a href="#" phx-click="say_hello" phx-target="<%= @myself %>">
      Say hello!
    </a>
    """
  end
end
# <%= inspect assigns %>
