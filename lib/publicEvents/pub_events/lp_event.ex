defmodule PublicEvents.PubEvents.LPEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lpevents" do
    field :description, :string
    field :end_time, :naive_datetime
    field :image, :string
    field :likes, :integer
    field :limitedParticipation, :boolean, default: false
    field :maxParticipants, :integer
    field :notes, :string
    field :price, :integer
    field :start_time, :naive_datetime
    field :title, :string
    field :type, :string
    field :url, :string
    field :venue, :string

    timestamps()
  end

  @doc false
  def changeset(lp_event, attrs) do
    lp_event
    |> cast(attrs, [:title, :description, :price, :likes, :start_time, :end_time, :limitedParticipation, :maxParticipants, :image, :url, :venue, :notes, :type])
    |> validate_required([:title, :description, :price, :likes, :start_time, :end_time, :limitedParticipation, :maxParticipants, :image, :url, :venue, :notes, :type])
  end
end
