defmodule TutoWeb.OrderView do
  use TutoWeb, :view

  def food_order_quantity(food_id) do
    content_tag :input, "", [id: "order_food_orders_" <> Integer.to_string(food_id)  <> "_quantity", min: "0", name: "order[food_orders][" <> Integer.to_string(food_id) <> "][quantity]", type: "number", value: "0", multiple: ""]
  end

  def food_order_food_select(food_id) do
    content_tag :input, "", [id: "order_food_orders_" <> Integer.to_string(food_id)  <> "_food", min: "0", name: "order[food_orders][" <> Integer.to_string(food_id) <> "][food]", type: "checkbox", multiple: ""]
  end


end
