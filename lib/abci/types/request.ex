defmodule ABCI.Types.Request do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof :value, 0
  field :echo, 2, type: ABCI.Types.RequestEcho, oneof: 0
  field :flush, 3, type: ABCI.Types.RequestFlush, oneof: 0
  field :info, 4, type: ABCI.Types.RequestInfo, oneof: 0
  field :set_option, 5, type: ABCI.Types.RequestSetOption, oneof: 0
  field :init_chain, 6, type: ABCI.Types.RequestInitChain, oneof: 0
  field :query, 7, type: ABCI.Types.RequestQuery, oneof: 0
  field :begin_block, 8, type: ABCI.Types.RequestBeginBlock, oneof: 0
  field :check_tx, 9, type: ABCI.Types.RequestCheckTx, oneof: 0
  field :deliver_tx, 19, type: ABCI.Types.RequestDeliverTx, oneof: 0
  field :end_block, 11, type: ABCI.Types.RequestEndBlock, oneof: 0
  field :commit, 12, type: ABCI.Types.RequestCommit, oneof: 0
end
