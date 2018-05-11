defmodule TutoWeb.Router do
  use TutoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TutoWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/foods", FoodController, :index, as: :pages
    resources "/foods", FoodController, except: [:index]
    resources "/orders", OrderController
    resources "/food_orders", FoodOrderController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TutoWeb do
  #   pipe_through :api
  # end
end
