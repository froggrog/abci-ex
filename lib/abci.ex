defmodule ABCI do
  @moduledoc """
  Documentation for ABCI.
  """

  alias ABCI.Server

  @doc """
  Start ABCI Server

  ## Examples

      iex> ABCI.Server.init(ABCI.Example.CounterApp)
  """
  def init(app) do
    Server.init(app)
  end

  @doc """
  Start ABCI Server in linked process
  """
  def start_link(app) do
    pid = spawn_link(fn -> Server.init(app) end)
    {:ok, pid}
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
    }
  end
end
