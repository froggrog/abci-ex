defmodule ABCI.Types.Response do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof :value, 0
  field :exception, 1, type: ABCI.Types.ResponseException, oneof: 0
  field :echo, 2, type: ABCI.Types.ResponseEcho, oneof: 0
  field :flush, 3, type: ABCI.Types.ResponseFlush, oneof: 0
  field :info, 4, type: ABCI.Types.ResponseInfo, oneof: 0
  field :set_option, 5, type: ABCI.Types.ResponseSetOption, oneof: 0
  field :init_chain, 6, type: ABCI.Types.ResponseInitChain, oneof: 0
  field :query, 7, type: ABCI.Types.ResponseQuery, oneof: 0
  field :begin_block, 8, type: ABCI.Types.ResponseBeginBlock, oneof: 0
  field :check_tx, 9, type: ABCI.Types.ResponseCheckTx, oneof: 0
  field :deliver_tx, 10, type: ABCI.Types.ResponseDeliverTx, oneof: 0
  field :end_block, 11, type: ABCI.Types.ResponseEndBlock, oneof: 0
  field :commit, 12, type: ABCI.Types.ResponseCommit, oneof: 0
end

