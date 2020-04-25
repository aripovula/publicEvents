defmodule TestComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <div class="hero">a-<%= @content %></div>
    """
  end
end
# <%= inspect assigns %>
