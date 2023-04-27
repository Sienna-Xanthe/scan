defmodule Scan.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Scan.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        hash_password: "some hash_password"
      })
      |> Scan.Accounts.create_user()

    user
  end
end
