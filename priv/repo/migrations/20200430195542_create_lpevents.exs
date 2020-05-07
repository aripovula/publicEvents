defmodule PublicEvents.Repo.Migrations.CreateLpevents do
  use Ecto.Migration

  def change do
    create table(:lpevents) do
      add :title, :string
      add :description, :text
      add :price, :integer, default: 0
      add :likes, :integer, default: 0
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :limitedParticipation, :boolean, default: false, null: false
      add :maxParticipants, :integer
      add :image, :string
      add :url, :string
      add :venue, :string
      add :notes, :string
      add :type, :string

      timestamps()
    end
  end
end
