defmodule PublicEvents.Accounts.FedCredential do
  use Ecto.Schema
  import Ecto.Changeset
  alias PublicEvents.Accounts.User

  schema "fed_credentials" do
    field :provider, :string
    field :token, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(fed_credential, attrs) do
    fed_credential
    |> cast(attrs, [:provider, :token])
    # |> validate_required([:provider, :token])
  end
end
