defmodule TutoWeb.ChefController do
  use TutoWeb, :controller
  alias Tuto.Kitchen

  def index(conn, _params) do
    orders = Kitchen.list_orders()
    orders_json = Kitchen.list_orders_to_json()
    render(conn, "index.html", orders: orders, orders_json: orders_json)
  end

end
