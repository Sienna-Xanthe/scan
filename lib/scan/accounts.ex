defmodule Scan.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Scan.Repo

  alias Scan.Accounts.User

  def get_user!(id), do: Repo.get!(User, id)

  def create(params) do
    params
    |> User.signup_changeset()
    |> Repo.insert()
  end
end
