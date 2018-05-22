defmodule TutoWeb.KitchenChannel do
  use TutoWeb, :channel
  alias Tuto.Kitchen

  def join("kitchen:" <> name, _payload, socket) do
      IO.inspect "entreeeee"
      {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("waiter", payload, socket) do
    IO.inspect "holiiiii"
    IO.inspect payload
    broadcast! socket, "waiter", payload
    {:reply, :ok, socket}
  end

  def handle_in("cancel_message", %{"message" => order_id}, socket) do
    order = Kitchen.get_order!(order_id)
    broadcast! socket, "cancel_order",
     %{"message" => "orden correctamente cancelada", orders: [Kitchen.order_to_json_preload(order)]}

    # case Kitchen.update(order, %{"status" => "Cancelado"}) do
    #   {:ok, order} ->
    #     broadcast! socket, "cancel_message",
    #      %{"message" => "orden correctamente cancelada", orders: [order_to_json_preload(order)]}
    #   {:error, _error} -> nil
    # end
    {:reply, :ok, socket}
  end

  def handle_in("new_order", payload, socket) do
    broadcast! socket, "new_order", payload
    {:reply, :ok, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (kitchen:lobby).



end
