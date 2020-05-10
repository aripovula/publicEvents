defmodule PublicEventsWeb.LPEventLive do
  use PublicEventsWeb, :live_view

  alias PublicEvents.PubEvents
  alias PublicEventsWeb.LPEventLiveView
  alias PublicEventsWeb.Router.Helpers, as: Routes

  def render(assigns), do: LPEventLiveView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page: 1, per_page: 2)}
  end

  def handle_params(params, _url, socket) do
    {page, ""} = Integer.parse(params["page"] || "1")
    {:noreply, socket |> assign(page: page) |> fetch()}
  end

  defp fetch(socket) do
    %{page: page, per_page: per_page} = socket.assigns
    lp_events = PubEvents.paginate_lpevents(page, per_page)
    assign(socket, lp_events: lp_events, page_title: "Listing Events – Page #{page}")
  end

  def handle_info({PubEvents, [:lp_event | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("keydown", %{"code" => "ArrowLeft"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page - 1)}
  end

  def handle_event("keydown", %{"code" => "ArrowRight"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page + 1)}
  end

  def handle_event("keydown", _, socket), do: {:noreply, socket}

  def handle_event("delete_lp_event", %{"id" => id}, socket) do
    lp_event = PubEvents.get_lp_event!(id)
    {:ok, _lp_event} = PubEvents.delete_lp_event(lp_event)
    {:noreply, push_patch(socket, to: Routes.live_path(socket, __MODULE__, socket.assigns.page))}
  end

  defp go_page(socket, page) when page > 0 do
    push_patch(socket, to: Routes.live_path(socket, __MODULE__, page))
  end

  defp go_page(socket, _page), do: socket
end
