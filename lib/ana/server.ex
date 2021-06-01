defmodule Ana.Server do
  @moduledoc """
  Wraps cowbow sockets' handler
  """
  require Logger
  use Supervisor

  def start_link([port, false]) do
    GenServer.start_link(__MODULE__, [port, :http])
  end

  def start_link([port, _secured]) do
    GenServer.start_link(__MODULE__, [port, :http])
  end

  def init([port, scheme]) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: scheme,
        plug: __MODULE__.Router,
        options: [
          dispatch: dispatch(),
          port: port
        ]
      )
    ]

    opts = [strategy: :one_for_one, name: Ana.Socket.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_,
       [
         {"/", __MODULE__.Handler, []},
         {:_, Plug.Cowboy.Handler, {__MODULE__.Router, []}}
       ]}
    ]
  end
end
