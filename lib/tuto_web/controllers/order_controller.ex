defmodule TutoWeb.OrderController do
  use TutoWeb, :controller

  alias Tuto.Kitchen
  alias Tuto.Kitchen.Order
  alias Tuto.Kitchen.FoodOrder

  def index(conn, params) do
    orders = Kitchen.list_orders_paginate(params)
    orders_json = Kitchen.list_orders_to_json(orders)
    render(conn, "index.html", orders: orders, orders_json: orders_json)
  end

  def new(conn, _params) do
    changeset = Kitchen.change_order(%Order{food_orders: [%FoodOrder{}]})
    foods = Kitchen.list_foods()
    render(conn, "new.html", changeset: changeset, foods: foods)
  end

  def create(conn, %{"order" => order_params}) do
    with {:ok, order} <- Kitchen.create_order(order_params),
          _food_order <- Kitchen.create_food_order_selected_params(order_params, order.id)
    do
      TutoWeb.Endpoint.broadcast! "kitchen:1", "new_order", Kitchen.order_to_json_preload(order)
      conn
      |> put_flash(:info, "Order created successfully.")
      |> redirect(to: order_path(conn, :index))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Kitchen.get_order!(id)
    render(conn, "show.html", order: order)
  end

  def edit(conn, %{"id" => id}) do
    order = Kitchen.get_order!(id)
    changeset = Kitchen.change_order(order)
    foods = Kitchen.list_foods()
    render(conn, "edit.html", order: order, changeset: changeset, foods: foods)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Kitchen.get_order!(id)
    with {:ok, order} <- Kitchen.update_order(order, order_params),
          _food_order <- Kitchen.create_food_order_selected_params(order_params, order.id)
    do
      TutoWeb.Endpoint.broadcast! "kitchen:1", "update_order", Kitchen.order_to_json_preload(order)
      conn
      |> put_flash(:info, "Order created successfully.")
      |> redirect(to: order_path(conn, :index))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Kitchen.get_order!(id)
    {:ok, _order} = Kitchen.delete_order(order)

    conn
    |> put_flash(:info, "Order deleted successfully.")
    |> redirect(to: order_path(conn, :index))
  end
end
