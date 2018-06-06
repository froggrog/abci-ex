defmodule ABCI.Example.CounterApp do
  @moduledoc """
  Example ABCI App
  https://github.com/tendermint/abci/tree/master/example/counter
  """

  @code_type_ok 0
  @code_type_encoding_error 1
  @code_type_bad_nonce 2

  alias ABCI.Types

  def init() do
    initial_state = %{hash_count: 0, tx_count: 0, serial: true}
    Agent.start_link(fn -> initial_state end, name: :counter_app)
    ABCI.init(__MODULE__)
  end

  def init_chain(req) do
    _ = req
    Types.ResponseInitChain.new(code: @code_type_ok)
  end

  def begin_block(req) do
    _ = req
    Types.ResponseBeginBlock.new(code: @code_type_ok)
  end

  def end_block(req) do
    _ = req
    Types.ResponseEndBlock.new(code: @code_type_ok)
  end

  def flush(req) do
    _ = req
    Types.ResponseFlush.new()
  end

  def commit(req) do
    _ = req
    state = Agent.get(:counter_app, & &1)
    Agent.update(:counter_app, fn state -> %{state | hash_count: state.hash_count + 1} end)

    if state.tx_count == 0 do
      Types.ResponseCommit.new()
    else
      hash = <<_::unsigned-integer-size(64)>> = <<state.tx_count::64>>
      Types.ResponseCommit.new(data: hash)
    end
  end

  def info(req) do
    _ = req
    state = Agent.get(:counter_app, & &1)
    result = "hashes: #{state.hash_count}, txs: #{state.tx_count}, serial: #{state.serial}"
    Types.ResponseInfo.new(data: result)
  end

  def echo(req) do
    msg = req.message
    Types.ResponseEcho.new(message: msg)
  end

  def set_option(req) do
    {key, value} = {req.key, req.value}

    if key == "serial" do
      case value do
        "on" -> Agent.update(:counter_app, fn state -> %{state | serial: true} end)
        "off" -> Agent.update(:counter_app, fn state -> %{state | serial: false} end)
      end
    end

    Types.ResponseSetOption.new()
  end

  def deliver_tx(req) do
    state = Agent.get(:counter_app, & &1)
    # Types.ResponseDeliverTx.new(code: @code_type_ok)
    response =
      if state.serial do
        over_max_tx_size(req.tx) || pad_tx(req.tx) |> deliver_nonce(state.tx_count)
      end

    if response.code == @code_type_ok do
      Agent.update(:counter_app, fn state -> %{state | tx_count: state.tx_count + 1} end)
    end

    response
  end

  def check_tx(req) do
    state = Agent.get(:counter_app, & &1)

    if state.serial do
      over_max_tx_size(req.tx) || pad_tx(req.tx) |> check_nonce(state.tx_count)
    end
  end

  # -- private

  defp pad_tx(tx) do
    tx8 = String.slice(<<0::64>>, 0..-(String.length(tx) + 1)) <> tx
    <<tx_value::big-integer-size(64)>> = tx8
    tx_value
  end

  defp deliver_nonce(tx_value, tx_count) do
    if tx_value != tx_count do
      Types.ResponseDeliverTx.new(
        code: @code_type_bad_nonce,
        log: "Invalid nonce. Expected #{tx_count}, got #{tx_value}"
      )
    else
      Types.ResponseDeliverTx.new(code: @code_type_ok)
    end
  end

  defp check_nonce(tx_value, tx_count) do
    if tx_value < tx_count do
      Types.ResponseCheckTx.new(
        code: @code_type_bad_nonce,
        log: "Invalid nonce. Expected #{tx_count}, got #{tx_value}"
      )
    else
      Types.ResponseCheckTx.new(code: @code_type_ok)
    end
  end

  defp over_max_tx_size(tx) do
    if String.length(tx) > 8 do
      Types.ResponseDeliverTx.new(
        code: @code_type_encoding_error,
        log: "Max tx size is 8 bytes, got #{String.length(tx)}"
      )
    end
  end
end
