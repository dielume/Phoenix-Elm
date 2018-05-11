defmodule Tuto.Kitchen.FoodOrder do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tuto.Kitchen.{Food, Order}

  schema "food_orders" do
    field :quantity, :integer
    field :status, :string
    belongs_to :food, Food
    belongs_to :order, Order


    timestamps()
  end

  @doc false
  def changeset(food_order, attrs) do
    food_order
    |> cast(attrs, [:quantity, :status, :food_id, :order_id])
    |> validate_required([:quantity, :status, :food_id, :order_id])
  end
end
