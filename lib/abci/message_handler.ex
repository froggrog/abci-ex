defmodule ABCI.MessageHandler do
  @moduledoc """
  Get a message from a socket, process it and send it back to the socket
  """

  use GenServer

  require Logger

  alias ABCI.Codec
  alias ABCI.Service

  @eol <<4, 26, 0>>

  def init(state), do: {:ok, state}

  def start_link(state), do: GenServer.start_link(__MODULE__, state)
  def receive(value, pid \\ __MODULE__), do: GenServer.cast(pid, {:receive, value})

  def handle_cast({:receive, data}, state) do
    state
    |> append(data)
    |> process()
  end

  defp append(state, ""), do: state
  defp append(state, data), do: %{state | buffer: state.buffer <> data}

  defp process(state) do
    case String.split(state.buffer, @eol, parts: 2) do
      [message, rest] ->
        process_message(state.service, message)
        process(%{state | buffer: rest})

      [_] ->
        {:noreply, state}
    end
  end

  defp process_message(service, "") do
    write_socket(<<>>, service.socket)
  end

  defp process_message(service, msg) do
    with {:ok, requests} <- Codec.decode(msg),
         {:ok, responses} <- requests |> Service.process(service.app) |> Codec.encode(),
         :ok <- write_socket(responses, service.socket)
    do
      :ok
    else
      {:error, reason} ->
        Logger.error("Error while processing message: #{inspect reason}, msg: #{inspect msg}")
    end
  end

  defp write_socket(data, socket) do
    :gen_tcp.send(socket, data <> @eol)
  end
end
