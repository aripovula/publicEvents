defmodule PublicEvents.AccountsTest do
  use PublicEvents.DataCase

  alias PublicEvents.Accounts

  describe "users" do
    alias PublicEvents.Accounts.User

    @valid_attrs %{name: "some name", username: "some username"}
    @update_attrs %{name: "some updated name", username: "some updated username"}
    @invalid_attrs %{name: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    def not_loaded_to_nil(a_map) do
      Map.replace!(a_map, :fed_credential, nil)
    end

    def not_loaded_to_nil_list(u_list) do
      Enum.map(
        u_list,
        fn x -> not_loaded_to_nil(x) end
      )
    end

    test "list_users/0 returns all users" do
      user = not_loaded_to_nil_list([user_fixture()])
      fetchedUsers = Accounts.list_users()
      assert fetchedUsers == user
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      fetchedUser = Accounts.get_user!(user.id)
      assert fetchedUser == not_loaded_to_nil(user)
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.name == "some name"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.name == "some updated name"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert not_loaded_to_nil(user) == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
