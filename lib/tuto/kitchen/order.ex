defmodule Tuto.Kitchen.Order do
  use Ecto.Schema
  import Ecto.Changeset


  schema "orders" do
    field :name, :string
    field :status, :string
    field :table, :integer

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:name, :status, :table])
    |> validate_required([:name, :status, :table])
  end
end
