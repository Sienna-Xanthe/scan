defmodule ScanWeb.Auth.SetAccount do
  @moduledoc """
  Set account for Forum
  """
  import Plug.Conn
  alias Scan.Repo

  def init(_opts), do: :ok

  def call(conn, _opts) do
    case conn.assigns[:user] do
      nil ->
        user = Repo.preload(conn.private.guardian_default_resource, [:camera])
        IO.inspect(user)
        assign(conn, :user, user)

      _user ->
        conn
    end
  end
end
