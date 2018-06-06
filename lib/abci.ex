defmodule ABCI do
  @moduledoc """
  Documentation for ABCI.
  """

  @doc """
  Start ABCI Server

  ## Examples

      iex> ABCI.Server.init(ABCI.Example.CounterApp)
  """
  def init(app) do
    ABCI.Server.init(app)
  end
end
