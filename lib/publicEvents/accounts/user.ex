defmodule PublicEvents.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PublicEvents.Accounts.FedCredential

  schema "users" do
    field :name, :string
    field :username, :string
    has_one :fed_credential, FedCredential

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
  end
end
