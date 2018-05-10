defmodule Tuto.Kitchen.FoodOrder do
  use Ecto.Schema
  import Ecto.Changeset


  schema "food_orders" do
    field :quantity, :integer
    field :status, :string
    field :food_id, :id
    field :order_id, :id

    timestamps()
  end

  @doc false
  def changeset(food_order, attrs) do
    food_order
    |> cast(attrs, [:quantity, :status])
    |> validate_required([:quantity, :status])
  end
end
