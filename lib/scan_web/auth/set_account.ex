defmodule ScanWeb.Auth.SetAccount do
  @moduledoc """
  设置账户信息
  """
  import Plug.Conn
  alias Scan.Repo

  def init(_opts), do: :ok

  def call(conn, _opts) do
    case conn.assigns[:user] do
      nil ->
        user = Repo.preload(conn.private.guardian_default_resource, [:camera])
        assign(conn, :user, user)

      _user ->
        conn
    end
  end
end
