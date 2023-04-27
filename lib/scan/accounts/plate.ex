defmodule Scan.Accounts.Plate do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "plate" do
    field :plate_color, :string
    field :plate_img, :string
    field :plate_number, :string
    field :camera_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(plate, attrs) do
    plate
    |> cast(attrs, [:plate_number, :plate_color, :plate_img])
    |> validate_required([:plate_number, :plate_color, :plate_img])
  end
end
