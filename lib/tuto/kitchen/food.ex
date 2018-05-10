defmodule Tuto.Kitchen.Food do
  use Ecto.Schema
  import Ecto.Changeset


  schema "foods" do
    field :description, :string
    field :name, :string
    field :photo, :string
    field :price, :integer

    timestamps()
  end

  @doc false
  def changeset(food, attrs) do
    food
    |> cast(attrs, [:name, :description, :price, :photo])
    |> validate_required([:name, :description, :price, :photo])
  end
end
