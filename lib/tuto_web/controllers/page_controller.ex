defmodule TutoWeb.PageController do
  use TutoWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
