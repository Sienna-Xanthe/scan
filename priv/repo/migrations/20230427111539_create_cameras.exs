defmodule Scan.Repo.Migrations.CreateCameras do
  use Ecto.Migration

  def change do
    create table(:cameras, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :camera_password, :string
      add :camera_address, :string
      add :camera_url, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:cameras, [:user_id])
  end
end
