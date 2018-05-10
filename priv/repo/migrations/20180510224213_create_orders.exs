defmodule Tuto.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :name, :string
      add :status, :string
      add :table, :integer

      timestamps()
    end

  end
end
