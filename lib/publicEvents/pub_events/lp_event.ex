defmodule PublicEvents.PubEvents.LPEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lpevents" do
    field :title, :string
    field :description, :string
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime
    field :price, :integer, default: 0
    field :likes, :integer, default: 0
    field :limitedParticipation, :boolean, default: false
    field :maxParticipants, :integer
    field :image, :string
    field :url, :string
    field :venue, :string
    field :notes, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(lp_event, attrs) do
    lp_event
    |> cast(attrs, [
      :title,
      :description,
      :price,
      :likes,
      :start_time,
      :end_time,
      :limitedParticipation,
      :maxParticipants,
      :image,
      :url,
      :venue,
      :notes,
      :type
    ])
    |> validate_required([:title, :start_time, :end_time, :type])
    |> validate_length(:title, min: 3, max: 100)
    |> validate_number(:price, greater_than_or_equal_to: 0)
    |> validate_number(:maxParticipants, greater_than: 0)
  end
end
