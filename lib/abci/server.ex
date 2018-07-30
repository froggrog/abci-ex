defmodule ABCI.Server do
  @moduledoc """
  Documentation for ABCI Server.
  """

  @default_port 26_658

  alias ABCI.MessageHandler

  @doc """
  Start listening socket

  ## Examples

      iex> ABCI.Server.init(ABCI.Example.CounterApp)

  """
  def init(app, port \\ @default_port) do
    {:ok, socket} =
      :gen_tcp.listen(
        port,
        [:binary, packet: :raw, active: false, reuseaddr: true]
      )

    loop_acceptor(app, socket)
  end

  defp loop_acceptor(app, socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    spawn(fn -> accepted(app, client) end)
    loop_acceptor(app, socket)
  end

  defp accepted(app, client) do
    {:ok, buffer_pid} = MessageHandler.start_link(%{service: %{app: app, socket: client}, buffer: <<>>})
    serve(app, client, buffer_pid)
  end

  defp serve(app, socket, buffer_pid) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        MessageHandler.receive(data, buffer_pid)
        serve(app, socket, buffer_pid)

      {:error, _} ->
        exit(:kill)
    end
  end
end
