defmodule Ana.Server.Handler do
  @behaviour :cowboy_websocket

  def init(req, state) do
    {:cowboy_websocket, req, state}
  end

  def websocket_handle({:text, message}, state) do
    case Jason.decode(message) do
      {:ok, json} -> websocket_handle({:json, json}, state)
      {:error, _} -> {:reply, {:text, "\"{\"error\": \"invalid json\"}"}, state}
    end
  end

  def websocket_handle({:json, _}, state) do
    {:reply, {:text, "hello world"}, state}
  end

  def websocket_info(_info, state) do
    {:reply, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
