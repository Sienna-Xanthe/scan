defmodule Scan.Repo.Migrations.CreatePlate do
  use Ecto.Migration

  def change do
    create table(:plate, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :plate_number, :string
      add :plate_color, :string
      add :plate_img, :string
      add :camera_id, references(:cameras, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:plate, [:camera_id])
  end
end
