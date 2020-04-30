defmodule PublicEvents.PubEvents do
  @moduledoc """
  The PubEvents context.
  """

  import Ecto.Query, warn: false
  alias PublicEvents.Repo

  alias PublicEvents.PubEvents.LPEvent

  @doc """
  Returns the list of lpevents.

  ## Examples

      iex> list_lpevents()
      [%LPEvent{}, ...]

  """
  def list_lpevents do
    Repo.all(LPEvent)
  end

  @doc """
  Gets a single lp_event.

  Raises `Ecto.NoResultsError` if the Lp event does not exist.

  ## Examples

      iex> get_lp_event!(123)
      %LPEvent{}

      iex> get_lp_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lp_event!(id), do: Repo.get!(LPEvent, id)

  @doc """
  Creates a lp_event.

  ## Examples

      iex> create_lp_event(%{field: value})
      {:ok, %LPEvent{}}

      iex> create_lp_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lp_event(attrs \\ %{}) do
    %LPEvent{}
    |> LPEvent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lp_event.

  ## Examples

      iex> update_lp_event(lp_event, %{field: new_value})
      {:ok, %LPEvent{}}

      iex> update_lp_event(lp_event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lp_event(%LPEvent{} = lp_event, attrs) do
    lp_event
    |> LPEvent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a lp_event.

  ## Examples

      iex> delete_lp_event(lp_event)
      {:ok, %LPEvent{}}

      iex> delete_lp_event(lp_event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lp_event(%LPEvent{} = lp_event) do
    Repo.delete(lp_event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lp_event changes.

  ## Examples

      iex> change_lp_event(lp_event)
      %Ecto.Changeset{data: %LPEvent{}}

  """
  def change_lp_event(%LPEvent{} = lp_event, attrs \\ %{}) do
    LPEvent.changeset(lp_event, attrs)
  end
end
