defmodule TutoWeb.KitchenChannel do
  use TutoWeb, :channel

  def join("kitchen:" <> name, _payload, socket) do
      IO.inspect "entreeeee"
      {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("shout", payload, socket) do
    IO.inspect "holiiiii"
    IO.inspect payload
    broadcast! socket, "pong", payload
    {:reply, :ok, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (kitchen:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end


end
