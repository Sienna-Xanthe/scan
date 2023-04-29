defmodule Scan.AccountsTest do
  use Scan.DataCase

  alias Scan.Accounts

  describe "users" do
    alias Scan.Accounts.User

    import Scan.AccountsFixtures

    @invalid_attrs %{email: nil, hash_password: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", hash_password: "some hash_password"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.hash_password == "some hash_password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", hash_password: "some updated hash_password"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.hash_password == "some updated hash_password"
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

  describe "cameras" do
    alias Scan.Accounts.Camera

    import Scan.AccountsFixtures

    @invalid_attrs %{camera_address: nil, camera_password: nil, camera_url: nil}

    test "list_cameras/0 returns all cameras" do
      camera = camera_fixture()
      assert Accounts.list_cameras() == [camera]
    end

    test "get_camera!/1 returns the camera with given id" do
      camera = camera_fixture()
      assert Accounts.get_camera!(camera.id) == camera
    end

    test "create_camera/1 with valid data creates a camera" do
      valid_attrs = %{
        camera_address: "some camera_address",
        camera_password: "some camera_password",
        camera_url: "some camera_url"
      }

      assert {:ok, %Camera{} = camera} = Accounts.create_camera(valid_attrs)
      assert camera.camera_address == "some camera_address"
      assert camera.camera_password == "some camera_password"
      assert camera.camera_url == "some camera_url"
    end

    test "create_camera/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_camera(@invalid_attrs)
    end

    test "update_camera/2 with valid data updates the camera" do
      camera = camera_fixture()

      update_attrs = %{
        camera_address: "some updated camera_address",
        camera_password: "some updated camera_password",
        camera_url: "some updated camera_url"
      }

      assert {:ok, %Camera{} = camera} = Accounts.update_camera(camera, update_attrs)
      assert camera.camera_address == "some updated camera_address"
      assert camera.camera_password == "some updated camera_password"
      assert camera.camera_url == "some updated camera_url"
    end

    test "update_camera/2 with invalid data returns error changeset" do
      camera = camera_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_camera(camera, @invalid_attrs)
      assert camera == Accounts.get_camera!(camera.id)
    end

    test "delete_camera/1 deletes the camera" do
      camera = camera_fixture()
      assert {:ok, %Camera{}} = Accounts.delete_camera(camera)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_camera!(camera.id) end
    end

    test "change_camera/1 returns a camera changeset" do
      camera = camera_fixture()
      assert %Ecto.Changeset{} = Accounts.change_camera(camera)
    end
  end

  describe "plate" do
    alias Scan.Accounts.Plate

    import Scan.AccountsFixtures

    @invalid_attrs %{plate_color: nil, plate_img: nil, plate_number: nil}

    test "list_plate/0 returns all plate" do
      plate = plate_fixture()
      assert Accounts.list_plate() == [plate]
    end

    test "get_plate!/1 returns the plate with given id" do
      plate = plate_fixture()
      assert Accounts.get_plate!(plate.id) == plate
    end

    test "create_plate/1 with valid data creates a plate" do
      valid_attrs = %{
        plate_color: "some plate_color",
        plate_img: "some plate_img",
        plate_number: "some plate_number"
      }

      assert {:ok, %Plate{} = plate} = Accounts.create_plate(valid_attrs)
      assert plate.plate_color == "some plate_color"
      assert plate.plate_img == "some plate_img"
      assert plate.plate_number == "some plate_number"
    end

    test "create_plate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_plate(@invalid_attrs)
    end

    test "update_plate/2 with valid data updates the plate" do
      plate = plate_fixture()

      update_attrs = %{
        plate_color: "some updated plate_color",
        plate_img: "some updated plate_img",
        plate_number: "some updated plate_number"
      }

      assert {:ok, %Plate{} = plate} = Accounts.update_plate(plate, update_attrs)
      assert plate.plate_color == "some updated plate_color"
      assert plate.plate_img == "some updated plate_img"
      assert plate.plate_number == "some updated plate_number"
    end

    test "update_plate/2 with invalid data returns error changeset" do
      plate = plate_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_plate(plate, @invalid_attrs)
      assert plate == Accounts.get_plate!(plate.id)
    end

    test "delete_plate/1 deletes the plate" do
      plate = plate_fixture()
      assert {:ok, %Plate{}} = Accounts.delete_plate(plate)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_plate!(plate.id) end
    end

    test "change_plate/1 returns a plate changeset" do
      plate = plate_fixture()
      assert %Ecto.Changeset{} = Accounts.change_plate(plate)
    end
  end

  describe "user_tokens" do
    alias Scan.Accounts.User_Token

    import Scan.AccountsFixtures

    @invalid_attrs %{context: nil, sent_to: nil, token: nil}

    test "list_user_tokens/0 returns all user_tokens" do
      user__token = user__token_fixture()
      assert Accounts.list_user_tokens() == [user__token]
    end

    test "get_user__token!/1 returns the user__token with given id" do
      user__token = user__token_fixture()
      assert Accounts.get_user__token!(user__token.id) == user__token
    end

    test "create_user__token/1 with valid data creates a user__token" do
      valid_attrs = %{context: "some context", sent_to: "some sent_to", token: "some token"}

      assert {:ok, %User_Token{} = user__token} = Accounts.create_user__token(valid_attrs)
      assert user__token.context == "some context"
      assert user__token.sent_to == "some sent_to"
      assert user__token.token == "some token"
    end

    test "create_user__token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user__token(@invalid_attrs)
    end

    test "update_user__token/2 with valid data updates the user__token" do
      user__token = user__token_fixture()

      update_attrs = %{
        context: "some updated context",
        sent_to: "some updated sent_to",
        token: "some updated token"
      }

      assert {:ok, %User_Token{} = user__token} =
               Accounts.update_user__token(user__token, update_attrs)

      assert user__token.context == "some updated context"
      assert user__token.sent_to == "some updated sent_to"
      assert user__token.token == "some updated token"
    end

    test "update_user__token/2 with invalid data returns error changeset" do
      user__token = user__token_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_user__token(user__token, @invalid_attrs)

      assert user__token == Accounts.get_user__token!(user__token.id)
    end

    test "delete_user__token/1 deletes the user__token" do
      user__token = user__token_fixture()
      assert {:ok, %User_Token{}} = Accounts.delete_user__token(user__token)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user__token!(user__token.id) end
    end

    test "change_user__token/1 returns a user__token changeset" do
      user__token = user__token_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user__token(user__token)
    end
  end
end
