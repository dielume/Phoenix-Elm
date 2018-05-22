defmodule TutoWeb.FoodController do
  use TutoWeb, :controller

  alias Tuto.Kitchen
  alias Tuto.Kitchen.Food

  def index(conn, params) do
    IO.inspect  params
    foods = Kitchen.list_foods_pagination(params)
    render(conn, "index.html", foods: foods)
  end

  def new(conn, _params) do
    changeset = Kitchen.change_food(%Food{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food" => food_params}) do
    case Kitchen.create_food(food_params) do
      {:ok, food} ->
        conn
        |> put_flash(:info, "Food created successfully.")
        |> redirect(to: food_path(conn, :show, food))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food = Kitchen.get_food!(id)
    render(conn, "show.html", food: food)
  end

  def edit(conn, %{"id" => id}) do
    food = Kitchen.get_food!(id)
    changeset = Kitchen.change_food(food)
    render(conn, "edit.html", food: food, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food" => food_params}) do
    food = Kitchen.get_food!(id)

    case Kitchen.update_food(food, food_params) do
      {:ok, food} ->
        conn
        |> put_flash(:info, "Food updated successfully.")
        |> redirect(to: food_path(conn, :show, food))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", food: food, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food = Kitchen.get_food!(id)
    {:ok, _food} = Kitchen.delete_food(food)

    conn
    |> put_flash(:info, "Food deleted successfully.")
    |> redirect(to: food_path(conn, :index))
  end
end
