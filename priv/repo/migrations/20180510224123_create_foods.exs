defmodule Tuto.Repo.Migrations.CreateFoods do
  use Ecto.Migration

  def change do
    create table(:foods) do
      add :name, :string
      add :description, :string
      add :price, :integer
      add :photo, :string

      timestamps()
    end

  end
end
