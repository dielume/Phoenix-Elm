defmodule Tuto.Repo.Migrations.CreateFoodOrders do
  use Ecto.Migration

  def change do
    create table(:food_orders) do
      add :quantity, :integer
      add :status, :string
      add :food_id, references(:food, on_delete: :nothing)
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps()
    end

    create index(:food_orders, [:food_id])
    create index(:food_orders, [:order_id])
  end
end
