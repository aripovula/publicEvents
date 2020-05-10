defmodule PublicEventsWeb.LPEventLive.NotFound do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias PublicEventsWeb.LPEventLive
  alias PublicEventsWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
    <h1>Event Not Found</h1>
    <span><%= link "Back", to: Routes.live_path(@socket, LPEventLive) %></span>
    """
  end

  def mount(_params, _, socket) do
    {:ok, socket}
  end
end
