defmodule PublicEventsWeb.LPEventNewTest do
  use PublicEvents.DataCase, async: true
  alias PublicEvents.PubEvents.LPEvent

  test "shows validation errors when title is too short" do
    changeset = LPEvent.changeset(%LPEvent{}, %{title: "I"})
    assert %{title: ["should be at least 3 character(s)"]} = errors_on(changeset)
  end

  test "shows validation errors when price is negative" do
    changeset = LPEvent.changeset(%LPEvent{}, %{price: "-2"})
    assert %{price: ["must be greater than or equal to 0"]} = errors_on(changeset)
  end

  test "shows validation errors when max participants is negative" do
    changeset = LPEvent.changeset(%LPEvent{}, %{maxParticipants: "-2"})
    assert %{maxParticipants: ["must be greater than 0"]} = errors_on(changeset)
  end

  test "shows validation errors when max participants is zero" do
    changeset = LPEvent.changeset(%LPEvent{}, %{maxParticipants: "0"})
    assert %{maxParticipants: ["must be greater than 0"]} = errors_on(changeset)
  end
end
