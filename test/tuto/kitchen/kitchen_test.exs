defmodule Tuto.KitchenTest do
  use Tuto.DataCase

  alias Tuto.Kitchen

  describe "foods" do
    alias Tuto.Kitchen.Food

    @valid_attrs %{description: "some description", name: "some name", photo: "some photo", price: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", photo: "some updated photo", price: 43}
    @invalid_attrs %{description: nil, name: nil, photo: nil, price: nil}

    def food_fixture(attrs \\ %{}) do
      {:ok, food} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Kitchen.create_food()

      food
    end

    test "list_foods/0 returns all foods" do
      food = food_fixture()
      assert Kitchen.list_foods() == [food]
    end

    test "get_food!/1 returns the food with given id" do
      food = food_fixture()
      assert Kitchen.get_food!(food.id) == food
    end

    test "create_food/1 with valid data creates a food" do
      assert {:ok, %Food{} = food} = Kitchen.create_food(@valid_attrs)
      assert food.description == "some description"
      assert food.name == "some name"
      assert food.photo == "some photo"
      assert food.price == 42
    end

    test "create_food/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Kitchen.create_food(@invalid_attrs)
    end

    test "update_food/2 with valid data updates the food" do
      food = food_fixture()
      assert {:ok, food} = Kitchen.update_food(food, @update_attrs)
      assert %Food{} = food
      assert food.description == "some updated description"
      assert food.name == "some updated name"
      assert food.photo == "some updated photo"
      assert food.price == 43
    end

    test "update_food/2 with invalid data returns error changeset" do
      food = food_fixture()
      assert {:error, %Ecto.Changeset{}} = Kitchen.update_food(food, @invalid_attrs)
      assert food == Kitchen.get_food!(food.id)
    end

    test "delete_food/1 deletes the food" do
      food = food_fixture()
      assert {:ok, %Food{}} = Kitchen.delete_food(food)
      assert_raise Ecto.NoResultsError, fn -> Kitchen.get_food!(food.id) end
    end

    test "change_food/1 returns a food changeset" do
      food = food_fixture()
      assert %Ecto.Changeset{} = Kitchen.change_food(food)
    end
  end

  describe "orders" do
    alias Tuto.Kitchen.Order

    @valid_attrs %{name: "some name", status: "some status", table: 42}
    @update_attrs %{name: "some updated name", status: "some updated status", table: 43}
    @invalid_attrs %{name: nil, status: nil, table: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Kitchen.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Kitchen.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Kitchen.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Kitchen.create_order(@valid_attrs)
      assert order.name == "some name"
      assert order.status == "some status"
      assert order.table == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Kitchen.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, order} = Kitchen.update_order(order, @update_attrs)
      assert %Order{} = order
      assert order.name == "some updated name"
      assert order.status == "some updated status"
      assert order.table == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Kitchen.update_order(order, @invalid_attrs)
      assert order == Kitchen.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Kitchen.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Kitchen.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Kitchen.change_order(order)
    end
  end

  describe "food_orders" do
    alias Tuto.Kitchen.FoodOrder

    @valid_attrs %{quantity: 42, status: "some status"}
    @update_attrs %{quantity: 43, status: "some updated status"}
    @invalid_attrs %{quantity: nil, status: nil}

    def food_order_fixture(attrs \\ %{}) do
      {:ok, food_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Kitchen.create_food_order()

      food_order
    end

    test "list_food_orders/0 returns all food_orders" do
      food_order = food_order_fixture()
      assert Kitchen.list_food_orders() == [food_order]
    end

    test "get_food_order!/1 returns the food_order with given id" do
      food_order = food_order_fixture()
      assert Kitchen.get_food_order!(food_order.id) == food_order
    end

    test "create_food_order/1 with valid data creates a food_order" do
      assert {:ok, %FoodOrder{} = food_order} = Kitchen.create_food_order(@valid_attrs)
      assert food_order.quantity == 42
      assert food_order.status == "some status"
    end

    test "create_food_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Kitchen.create_food_order(@invalid_attrs)
    end

    test "update_food_order/2 with valid data updates the food_order" do
      food_order = food_order_fixture()
      assert {:ok, food_order} = Kitchen.update_food_order(food_order, @update_attrs)
      assert %FoodOrder{} = food_order
      assert food_order.quantity == 43
      assert food_order.status == "some updated status"
    end

    test "update_food_order/2 with invalid data returns error changeset" do
      food_order = food_order_fixture()
      assert {:error, %Ecto.Changeset{}} = Kitchen.update_food_order(food_order, @invalid_attrs)
      assert food_order == Kitchen.get_food_order!(food_order.id)
    end

    test "delete_food_order/1 deletes the food_order" do
      food_order = food_order_fixture()
      assert {:ok, %FoodOrder{}} = Kitchen.delete_food_order(food_order)
      assert_raise Ecto.NoResultsError, fn -> Kitchen.get_food_order!(food_order.id) end
    end

    test "change_food_order/1 returns a food_order changeset" do
      food_order = food_order_fixture()
      assert %Ecto.Changeset{} = Kitchen.change_food_order(food_order)
    end
  end
end
