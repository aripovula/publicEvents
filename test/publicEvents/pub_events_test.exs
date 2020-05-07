defmodule PublicEvents.PubEventsTest do
  use PublicEvents.DataCase

  alias PublicEvents.PubEvents

  describe "lpevents" do
    alias PublicEvents.PubEvents.LPEvent

    @valid_attrs %{
      description: "some description",
      end_time: ~N[2010-04-17 14:00:00],
      image: "some image",
      likes: 42,
      limitedParticipation: true,
      maxParticipants: 42,
      notes: "some notes",
      price: 42,
      start_time: ~N[2010-04-17 14:00:00],
      title: "some title",
      type: "some type",
      url: "some url",
      venue: "some venue"
    }
    @update_attrs %{
      description: "some updated description",
      end_time: ~N[2011-05-18 15:01:01],
      image: "some updated image",
      likes: 43,
      limitedParticipation: false,
      maxParticipants: 43,
      notes: "some updated notes",
      price: 43,
      start_time: ~N[2011-05-18 15:01:01],
      title: "some updated title",
      type: "some updated type",
      url: "some updated url",
      venue: "some updated venue"
    }
    @invalid_attrs %{
      description: nil,
      end_time: nil,
      image: nil,
      likes: nil,
      limitedParticipation: nil,
      maxParticipants: nil,
      notes: nil,
      price: nil,
      start_time: nil,
      title: nil,
      type: nil,
      url: nil,
      venue: nil
    }

    def lp_event_fixture(attrs \\ %{}) do
      {:ok, lp_event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PubEvents.create_lp_event()

      lp_event
    end

    test "list_lpevents/0 returns all lpevents" do
      lp_event = lp_event_fixture()
      assert PubEvents.list_lpevents() == [lp_event]
    end

    test "get_lp_event!/1 returns the lp_event with given id" do
      lp_event = lp_event_fixture()
      assert PubEvents.get_lp_event!(lp_event.id) == lp_event
    end

    test "create_lp_event/1 with valid data creates a lp_event" do
      assert {:ok, %LPEvent{} = lp_event} = PubEvents.create_lp_event(@valid_attrs)
      assert lp_event.description == "some description"
      assert lp_event.end_time == ~N[2010-04-17 14:00:00]
      assert lp_event.image == "some image"
      assert lp_event.likes == 42
      assert lp_event.limitedParticipation == true
      assert lp_event.maxParticipants == 42
      assert lp_event.notes == "some notes"
      assert lp_event.price == 42
      assert lp_event.start_time == ~N[2010-04-17 14:00:00]
      assert lp_event.title == "some title"
      assert lp_event.type == "some type"
      assert lp_event.url == "some url"
      assert lp_event.venue == "some venue"
    end

    test "create_lp_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PubEvents.create_lp_event(@invalid_attrs)
    end

    test "update_lp_event/2 with valid data updates the lp_event" do
      lp_event = lp_event_fixture()
      assert {:ok, %LPEvent{} = lp_event} = PubEvents.update_lp_event(lp_event, @update_attrs)
      assert lp_event.description == "some updated description"
      assert lp_event.end_time == ~N[2011-05-18 15:01:01]
      assert lp_event.image == "some updated image"
      assert lp_event.likes == 43
      assert lp_event.limitedParticipation == false
      assert lp_event.maxParticipants == 43
      assert lp_event.notes == "some updated notes"
      assert lp_event.price == 43
      assert lp_event.start_time == ~N[2011-05-18 15:01:01]
      assert lp_event.title == "some updated title"
      assert lp_event.type == "some updated type"
      assert lp_event.url == "some updated url"
      assert lp_event.venue == "some updated venue"
    end

    test "update_lp_event/2 with invalid data returns error changeset" do
      lp_event = lp_event_fixture()
      assert {:error, %Ecto.Changeset{}} = PubEvents.update_lp_event(lp_event, @invalid_attrs)
      assert lp_event == PubEvents.get_lp_event!(lp_event.id)
    end

    test "delete_lp_event/1 deletes the lp_event" do
      lp_event = lp_event_fixture()
      assert {:ok, %LPEvent{}} = PubEvents.delete_lp_event(lp_event)
      assert_raise Ecto.NoResultsError, fn -> PubEvents.get_lp_event!(lp_event.id) end
    end

    test "change_lp_event/1 returns a lp_event changeset" do
      lp_event = lp_event_fixture()
      assert %Ecto.Changeset{} = PubEvents.change_lp_event(lp_event)
    end
  end
end
