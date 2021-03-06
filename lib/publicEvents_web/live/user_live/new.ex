defmodule PublicEventsWeb.UserLive.New do
  use Phoenix.LiveView

  alias PublicEvents.Accounts
  alias PublicEvents.Accounts.User
  alias PublicEventsWeb.UserLiveView
  alias PublicEventsWeb.Router.Helpers, as: Routes

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user(%User{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns), do: Phoenix.View.render(UserLiveView, "new.html", assigns)

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      %User{}
      |> Accounts.change_user(user_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        socket
        |> put_flash(:info, "user created")
        |> redirect(to: Routes.live_path(socket, UserLive.Show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
