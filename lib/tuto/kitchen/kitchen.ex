defmodule Tuto.Kitchen do
  @moduledoc """
  The Kitchen context.
  """

  import Ecto.Query, warn: false
  alias Tuto.Repo
  alias Tuto.Kitchen.{Order, Food, FoodOrder}

# Food section

  def list_foods do
    Food
    |> Repo.all
  end

  def list_foods_pagination(params) do
    Food
    |> Repo.paginate(params)
  end

  def get_food!(id), do: Repo.get!(Food, id)

  def create_food(attrs \\ %{}) do
    %Food{}
    |> Food.changeset(attrs)
    |> Repo.insert()
  end

  def update_food(%Food{} = food, attrs) do
    food
    |> Food.changeset(attrs)
    |> Repo.update()
  end

  def delete_food(%Food{} = food) do
    Repo.delete(food)
  end

  def change_food(%Food{} = food) do
    Food.changeset(food, %{})
  end

# Order section

  def waiter_collection do
    ["Waiter1": "Waiter1", "Waiter2": "Waiter2", "Waiter3": "Waiter3", "Waiter4": "Waiter4", "Waiter5": "Waiter5"]
  end

  def table_collection do
    1..20
  end

  def list_orders do
    Order
    |> Repo.all
  end

  def list_orders_to_json do
    Order
    |> Repo.all
    |> Repo.preload(:food_orders)
    |> Enum.map(fn order -> %Order{order | food_orders: (order.food_orders |> Repo.preload(:food))} end)
    |> Enum.map(fn order -> order_to_json(order) end)
    |> Poison.encode!
  end

  defp order_to_json(%Order{} = order) do
    %{ "id" => order.id,
       "waiter" => order.waiter,
       "table" => order.table,
       "status" => order.status,
       "food_order" =>   Enum.map(order.food_orders, &food_order_to_json(&1))
    }
  end

  defp food_order_to_json(%FoodOrder{} = food_order) do
    %{
      "food" => food_order.food.name,
      "status" => food_order.status,
      "quantity" => food_order.quantity,
      "price" => food_order.food.price
    }
  end

  def get_order!(id), do: Repo.get!(Order, id)

  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  def change_order(%Order{} = order) do
    Order.changeset(order, %{})
  end

# FoodOrder section

  def list_food_orders do
    Repo.all(FoodOrder)
  end

  def get_food_order!(id), do: Repo.get!(FoodOrder, id)


  def create_food_order(attrs \\ %{}) do
    %FoodOrder{}
    |> FoodOrder.changeset(attrs)
    |> Repo.insert()
  end

  def create_food_order_selected_params(params, order_id) do
    params["food_orders"]
    |> Map.to_list
    |> Enum.filter( fn {_id,food_order} -> Map.has_key?(food_order, "food") end)
    |> Enum.map( fn {id,food_order} -> %{food_id: id, quantity: food_order["quantity"], order_id: order_id, status: "Espera"} end )
    |> Enum.map(fn param -> create_food_order(param) end)
  end


  def update_food_order(%FoodOrder{} = food_order, attrs) do
    food_order
    |> FoodOrder.changeset(attrs)
    |> Repo.update()
  end

  def delete_food_order(%FoodOrder{} = food_order) do
    Repo.delete(food_order)
  end


  def change_food_order(%FoodOrder{} = food_order) do
    FoodOrder.changeset(food_order, %{})
  end
end
