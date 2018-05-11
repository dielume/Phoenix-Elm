defmodule Tuto.Kitchen.Food do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tuto.Kitchen.FoodOrder

  schema "foods" do
    field :description, :string
    field :name, :string
    field :photo, :string
    field :price, :integer
    has_many :food_orders, FoodOrder

    timestamps()
  end

  @doc false
  def changeset(food, attrs) do
    food
    |> cast(attrs, [:name, :description, :price, :photo])
    |> validate_required([:name, :price, :photo])
  end
end
