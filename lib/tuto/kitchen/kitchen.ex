defmodule Tuto.Kitchen do
  @moduledoc """
  The Kitchen context.
  """

  import Ecto.Query, warn: false
  alias Tuto.Repo

  alias Tuto.Kitchen.Food

  def list_foods do
    Repo.all(Food)
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

  alias Tuto.Kitchen.Order

  def list_orders do
    Repo.all(Order)
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

  alias Tuto.Kitchen.FoodOrder

  def list_food_orders do
    Repo.all(FoodOrder)
  end

  def get_food_order!(id), do: Repo.get!(FoodOrder, id)


  def create_food_order(attrs \\ %{}) do
    %FoodOrder{}
    |> FoodOrder.changeset(attrs)
    |> Repo.insert()
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
