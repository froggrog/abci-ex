defmodule ABCI.Service do
  @moduledoc """
    Service to provide request to response across ABCI App
  """
  alias ABCI.Types

  require Logger

  @callbacks ~w(
    info set_option query check_tx init_chain begin_block deliver_tx
    commit end_block echo flush
  )a

  def process(requests, app) do
    Enum.map(requests, &(process_one(&1, app)))
  end

  defp process_one(%{value: {value, req}}, app) when value in @callbacks do
    {value, apply(app, value, [req])}
    |> build_response()
  end

  defp process_one(%{value: {value, _}}, _) do
    Logger.error("Callback not implemented: #{inspect value}")
    Types.ResponseException.new(data: "Can't handle request #{inspect value}")
    |> build_response()
  end

  defp build_response(resp), do: Types.Response.new(value: resp)
end
