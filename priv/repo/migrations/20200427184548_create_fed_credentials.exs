defmodule PublicEvents.Repo.Migrations.CreateFedCredentials do
  use Ecto.Migration

  def change do
    create table(:fed_credentials) do
      add :provider, :string
      add :token, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:fed_credentials, [:user_id])
  end
end
