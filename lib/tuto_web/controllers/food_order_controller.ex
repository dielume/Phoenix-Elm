defmodule TutoWeb.FoodOrderController do
  use TutoWeb, :controller

  alias Tuto.Kitchen
  alias Tuto.Kitchen.FoodOrder

  def index(conn, _params) do
    food_orders = Kitchen.list_food_orders()
    render(conn, "index.html", food_orders: food_orders)
  end

  def new(conn, _params) do
    changeset = Kitchen.change_food_order(%FoodOrder{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food_order" => food_order_params}) do
    case Kitchen.create_food_order(food_order_params) do
      {:ok, food_order} ->
        conn
        |> put_flash(:info, "Food order created successfully.")
        |> redirect(to: food_order_path(conn, :show, food_order))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food_order = Kitchen.get_food_order!(id)
    render(conn, "show.html", food_order: food_order)
  end

  def edit(conn, %{"id" => id}) do
    food_order = Kitchen.get_food_order!(id)
    changeset = Kitchen.change_food_order(food_order)
    render(conn, "edit.html", food_order: food_order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food_order" => food_order_params}) do
    food_order = Kitchen.get_food_order!(id)

    case Kitchen.update_food_order(food_order, food_order_params) do
      {:ok, food_order} ->
        conn
        |> put_flash(:info, "Food order updated successfully.")
        |> redirect(to: food_order_path(conn, :show, food_order))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", food_order: food_order, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food_order = Kitchen.get_food_order!(id)
    {:ok, _food_order} = Kitchen.delete_food_order(food_order)

    conn
    |> put_flash(:info, "Food order deleted successfully.")
    |> redirect(to: food_order_path(conn, :index))
  end
end
