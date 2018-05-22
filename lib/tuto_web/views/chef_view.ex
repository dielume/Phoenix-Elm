defmodule TutoWeb.ChefView do
  use TutoWeb, :view

  def index_order_elm(data) do
    content_tag :div, "", [id: "elm-chef", data: data]
  end
end
