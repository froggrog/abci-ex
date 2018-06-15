use OkJose

defmodule ABCI.MessageHandler do
  @moduledoc """
  Get a message from a socket, process it and send it back to the socket
  """

  use GenServer

  alias ABCI.Codec
  alias ABCI.Service

  @eol <<4, 26, 0>>

  def init(state), do: {:ok, state}

  def create(state), do: GenServer.start_link(__MODULE__, state)
  def receive(value, pid \\ __MODULE__), do: GenServer.cast(pid, {:receive, value})

  def handle_cast({:receive, data}, state) do
    state
    |> append(data)
    |> process
  end

  defp append(state, ""), do: %{state | buffer: ""}
  defp append(state, data), do: %{state | buffer: state.buffer <> data}

  defp process(state) do
    case extract(state.buffer) do
      {:statement, data, statement} ->
        if String.length(statement) > 0 do
          handle(state.service, {:ok, statement})
        else
          write_socket(<<>>, state.service.socket)
        end

        process(%{state | buffer: data})

      {:nothing, _} ->
        {:noreply, state}
    end
  end

  defp extract(data) do
    case String.split(data, @eol, parts: 2) do
      [match, rest] -> {:statement, rest, match}
      [rest] -> {:nothing, rest}
    end
  end

  defp handle(state, msg) do
    msg
    |> Codec.decode()
    |> Service.start_link(state.app)
    |> Codec.encode()
    |> write_socket(state.socket)
    |> Pipe.ok()
    |> (fn x ->
          case x do
            :ok -> nil
            {:error, reason} -> IO.puts("Serve error: #{inspect(reason)}")
          end

          x
        end).()
  end

  defp write_socket(raw, socket) do
    :gen_tcp.send(socket, raw <> @eol)
  end
end
