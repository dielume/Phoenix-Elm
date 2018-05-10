defmodule Tuto.Kitchen do
  @moduledoc """
  The Kitchen context.
  """

  import Ecto.Query, warn: false
  alias Tuto.Repo

  alias Tuto.Kitchen.Food

  @doc """
  Returns the list of foods.

  ## Examples

      iex> list_foods()
      [%Food{}, ...]

  """
  def list_foods do
    Repo.all(Food)
  end

  @doc """
  Gets a single food.

  Raises `Ecto.NoResultsError` if the Food does not exist.

  ## Examples

      iex> get_food!(123)
      %Food{}

      iex> get_food!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food!(id), do: Repo.get!(Food, id)

  @doc """
  Creates a food.

  ## Examples

      iex> create_food(%{field: value})
      {:ok, %Food{}}

      iex> create_food(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food(attrs \\ %{}) do
    %Food{}
    |> Food.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food.

  ## Examples

      iex> update_food(food, %{field: new_value})
      {:ok, %Food{}}

      iex> update_food(food, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food(%Food{} = food, attrs) do
    food
    |> Food.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Food.

  ## Examples

      iex> delete_food(food)
      {:ok, %Food{}}

      iex> delete_food(food)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food(%Food{} = food) do
    Repo.delete(food)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food changes.

  ## Examples

      iex> change_food(food)
      %Ecto.Changeset{source: %Food{}}

  """
  def change_food(%Food{} = food) do
    Food.changeset(food, %{})
  end

  alias Tuto.Kitchen.Order

  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order)
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{source: %Order{}}

  """
  def change_order(%Order{} = order) do
    Order.changeset(order, %{})
  end

  alias Tuto.Kitchen.FoodOrder

  @doc """
  Returns the list of food_orders.

  ## Examples

      iex> list_food_orders()
      [%FoodOrder{}, ...]

  """
  def list_food_orders do
    Repo.all(FoodOrder)
  end

  @doc """
  Gets a single food_order.

  Raises `Ecto.NoResultsError` if the Food order does not exist.

  ## Examples

      iex> get_food_order!(123)
      %FoodOrder{}

      iex> get_food_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_order!(id), do: Repo.get!(FoodOrder, id)

  @doc """
  Creates a food_order.

  ## Examples

      iex> create_food_order(%{field: value})
      {:ok, %FoodOrder{}}

      iex> create_food_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_order(attrs \\ %{}) do
    %FoodOrder{}
    |> FoodOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_order.

  ## Examples

      iex> update_food_order(food_order, %{field: new_value})
      {:ok, %FoodOrder{}}

      iex> update_food_order(food_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_order(%FoodOrder{} = food_order, attrs) do
    food_order
    |> FoodOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FoodOrder.

  ## Examples

      iex> delete_food_order(food_order)
      {:ok, %FoodOrder{}}

      iex> delete_food_order(food_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_order(%FoodOrder{} = food_order) do
    Repo.delete(food_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_order changes.

  ## Examples

      iex> change_food_order(food_order)
      %Ecto.Changeset{source: %FoodOrder{}}

  """
  def change_food_order(%FoodOrder{} = food_order) do
    FoodOrder.changeset(food_order, %{})
  end
end
