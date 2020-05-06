defmodule PublicEventsWeb.UserLive.Index do
  use Phoenix.LiveView

  alias PublicEvents.Accounts
  alias PublicEventsWeb.UserLiveView
  alias PublicEventsWeb.Router.Helpers, as: Routes

  def render(assigns), do: UserLiveView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page: 1, per_page: 2, users_qnty: Accounts.users_count)}
  end

  def handle_params(params, _url, socket) do
    {page, ""} = Integer.parse(params["page"] || "1")
    {:noreply, socket |> assign(page: page) |> fetch()}
  end

  defp fetch(socket) do
    %{page: page, per_page: per_page} = socket.assigns
    users = Accounts.paginate_users(page, per_page)
    assign(socket, users: users, page_title: "Listing Users – Page #{page}")
  end

  def handle_info({Accounts, [:user | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("keydown", %{"code" => "ArrowLeft"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page - 1)}
  end
  def handle_event("keydown", %{"code" => "ArrowRight"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page + 1)}
  end
  def handle_event("keydown", _, socket), do: {:noreply, socket}

  def handle_event("delete_user", %{"id" => id}, socket) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    {:noreply, socket}
  end

  defp go_page(socket, page) when page > 0 do
    push_patch(socket, to: Routes.live_path(socket, __MODULE__, page))
  end
  defp go_page(socket, _page), do: socket
end
