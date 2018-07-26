defmodule ABCI.Service do
  @moduledoc """
    Service to provide request to response across ABCI App
  """
  alias ABCI.Types

  def start_link(requests, app) do
    {:ok, Enum.map(requests, fn req -> handle(req, app) end)}
  end

  defp handle(request, app) do
    response =
      case request.value do
        # Info/Query connection
        {:info, req} ->
          {:info, app.info(req)}

        {:set_option, req} ->
          {:set_option, app.set_option(req)}

        {:query, req} ->
          {:query, app.query(req)}

        # Mempool connection
        {:check_tx, req} ->
          {:check_tx, app.check_tx(req)}

        # Consensus connection
        {:init_chain, req} ->
          {:init_chain, app.init_chain(req)}

        {:begin_block, req} ->
          {:begin_block, app.begin_block(req)}

        {:deliver_tx, req} ->
          {:deliver_tx, app.deliver_tx(req)}

        {:commit, req} ->
          {:commit, app.commit(req)}

        {:end_block, req} ->
          {:end_block, app.end_block(req)}

        # Miscellaneous connection
        {:echo, req} ->
          {:echo, app.echo(req)}

        {:flush, req} ->
          {:flush, app.flush(req)}

        _ ->
          Types.ResponseException.new(data: "Can't handling request")
      end

    Types.Response.new(value: response)
  end
end
