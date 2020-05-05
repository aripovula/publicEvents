defmodule PublicEvents.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias PublicEvents.Repo
  # alias PublicEvents.Accounts.User
  alias PublicEvents.Accounts.{User, FedCredential}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    User
    |> Repo.all()
    |> Repo.preload(:fed_credential)
  end

  def paginate_users(current_page, per_page) do
    Repo.all(
      from u in User,
        order_by: [asc: u.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload(:fed_credential)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:fed_credential, with: &FedCredential.changeset/2)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:fed_credential, with: &FedCredential.changeset/2)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  # alias PublicEvents.Accounts.FedCredential

  @doc """
  Returns the list of fed_credentials.

  ## Examples

      iex> list_fed_credentials()
      [%FedCredential{}, ...]

  """
  def list_fed_credentials do
    Repo.all(FedCredential)
  end

  @doc """
  Gets a single fed_credential.

  Raises `Ecto.NoResultsError` if the Fed credential does not exist.

  ## Examples

      iex> get_fed_credential!(123)
      %FedCredential{}

      iex> get_fed_credential!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fed_credential!(id), do: Repo.get!(FedCredential, id)

  @doc """
  Creates a fed_credential.

  ## Examples

      iex> create_fed_credential(%{field: value})
      {:ok, %FedCredential{}}

      iex> create_fed_credential(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fed_credential(attrs \\ %{}) do
    %FedCredential{}
    |> FedCredential.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fed_credential.

  ## Examples

      iex> update_fed_credential(fed_credential, %{field: new_value})
      {:ok, %FedCredential{}}

      iex> update_fed_credential(fed_credential, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fed_credential(%FedCredential{} = fed_credential, attrs) do
    fed_credential
    |> FedCredential.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fed_credential.

  ## Examples

      iex> delete_fed_credential(fed_credential)
      {:ok, %FedCredential{}}

      iex> delete_fed_credential(fed_credential)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fed_credential(%FedCredential{} = fed_credential) do
    Repo.delete(fed_credential)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fed_credential changes.

  ## Examples

      iex> change_fed_credential(fed_credential)
      %Ecto.Changeset{data: %FedCredential{}}

  """
  def change_fed_credential(%FedCredential{} = fed_credential, attrs \\ %{}) do
    FedCredential.changeset(fed_credential, attrs)
  end
end
