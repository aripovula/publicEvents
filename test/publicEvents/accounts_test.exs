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

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
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
      assert user == Accounts.get_user!(user.id)
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

  describe "fed_credentials" do
    alias PublicEvents.Accounts.FedCredential

    @valid_attrs %{provider: "some provider", token: "some token"}
    @update_attrs %{provider: "some updated provider", token: "some updated token"}
    @invalid_attrs %{provider: nil, token: nil}

    def fed_credential_fixture(attrs \\ %{}) do
      {:ok, fed_credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_fed_credential()

      fed_credential
    end

    test "list_fed_credentials/0 returns all fed_credentials" do
      fed_credential = fed_credential_fixture()
      assert Accounts.list_fed_credentials() == [fed_credential]
    end

    test "get_fed_credential!/1 returns the fed_credential with given id" do
      fed_credential = fed_credential_fixture()
      assert Accounts.get_fed_credential!(fed_credential.id) == fed_credential
    end

    test "create_fed_credential/1 with valid data creates a fed_credential" do
      assert {:ok, %FedCredential{} = fed_credential} = Accounts.create_fed_credential(@valid_attrs)
      assert fed_credential.provider == "some provider"
      assert fed_credential.token == "some token"
    end

    test "create_fed_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_fed_credential(@invalid_attrs)
    end

    test "update_fed_credential/2 with valid data updates the fed_credential" do
      fed_credential = fed_credential_fixture()
      assert {:ok, %FedCredential{} = fed_credential} = Accounts.update_fed_credential(fed_credential, @update_attrs)
      assert fed_credential.provider == "some updated provider"
      assert fed_credential.token == "some updated token"
    end

    test "update_fed_credential/2 with invalid data returns error changeset" do
      fed_credential = fed_credential_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_fed_credential(fed_credential, @invalid_attrs)
      assert fed_credential == Accounts.get_fed_credential!(fed_credential.id)
    end

    test "delete_fed_credential/1 deletes the fed_credential" do
      fed_credential = fed_credential_fixture()
      assert {:ok, %FedCredential{}} = Accounts.delete_fed_credential(fed_credential)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_fed_credential!(fed_credential.id) end
    end

    test "change_fed_credential/1 returns a fed_credential changeset" do
      fed_credential = fed_credential_fixture()
      assert %Ecto.Changeset{} = Accounts.change_fed_credential(fed_credential)
    end
  end
end
