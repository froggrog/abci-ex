defmodule ABCI.Types.ConsensusParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_size: ABCI.Types.BlockSize.t(),
          tx_size: ABCI.Types.TxSize.t(),
          block_gossip: ABCI.Types.BlockGossip.t()
        }
  defstruct [:block_size, :tx_size, :block_gossip]

  field :block_size, 1, type: ABCI.Types.BlockSize
  field :tx_size, 2, type: ABCI.Types.TxSize
  field :block_gossip, 3, type: ABCI.Types.BlockGossip
end

