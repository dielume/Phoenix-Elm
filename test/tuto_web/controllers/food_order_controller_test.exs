defmodule TutoWeb.FoodOrderControllerTest do
  use TutoWeb.ConnCase

  alias Tuto.Kitchen

  @create_attrs %{quantity: 42, status: "some status"}
  @update_attrs %{quantity: 43, status: "some updated status"}
  @invalid_attrs %{quantity: nil, status: nil}

  def fixture(:food_order) do
    {:ok, food_order} = Kitchen.create_food_order(@create_attrs)
    food_order
  end

  describe "index" do
    test "lists all food_orders", %{conn: conn} do
      conn = get conn, food_order_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Food orders"
    end
  end

  describe "new food_order" do
    test "renders form", %{conn: conn} do
      conn = get conn, food_order_path(conn, :new)
      assert html_response(conn, 200) =~ "New Food order"
    end
  end

  describe "create food_order" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, food_order_path(conn, :create), food_order: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == food_order_path(conn, :show, id)

      conn = get conn, food_order_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Food order"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, food_order_path(conn, :create), food_order: @invalid_attrs
      assert html_response(conn, 200) =~ "New Food order"
    end
  end

  describe "edit food_order" do
    setup [:create_food_order]

    test "renders form for editing chosen food_order", %{conn: conn, food_order: food_order} do
      conn = get conn, food_order_path(conn, :edit, food_order)
      assert html_response(conn, 200) =~ "Edit Food order"
    end
  end

  describe "update food_order" do
    setup [:create_food_order]

    test "redirects when data is valid", %{conn: conn, food_order: food_order} do
      conn = put conn, food_order_path(conn, :update, food_order), food_order: @update_attrs
      assert redirected_to(conn) == food_order_path(conn, :show, food_order)

      conn = get conn, food_order_path(conn, :show, food_order)
      assert html_response(conn, 200) =~ "some updated status"
    end

    test "renders errors when data is invalid", %{conn: conn, food_order: food_order} do
      conn = put conn, food_order_path(conn, :update, food_order), food_order: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Food order"
    end
  end

  describe "delete food_order" do
    setup [:create_food_order]

    test "deletes chosen food_order", %{conn: conn, food_order: food_order} do
      conn = delete conn, food_order_path(conn, :delete, food_order)
      assert redirected_to(conn) == food_order_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, food_order_path(conn, :show, food_order)
      end
    end
  end

  defp create_food_order(_) do
    food_order = fixture(:food_order)
    {:ok, food_order: food_order}
  end
end
