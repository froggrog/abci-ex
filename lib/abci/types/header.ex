defmodule ABCI.Types.Header do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          chain_id: String.t(),
          height: integer,
          time: integer,
          num_txs: integer,
          last_block_id: ABCI.Types.BlockID.t(),
          last_commit_hash: String.t(),
          data_hash: String.t(),
          validators_hash: String.t(),
          app_hash: String.t()
        }
  defstruct [
    :chain_id,
    :height,
    :time,
    :num_txs,
    :last_block_id,
    :last_commit_hash,
    :data_hash,
    :validators_hash,
    :app_hash
  ]

  field :chain_id, 1, type: :string
  field :height, 2, type: :int64
  field :time, 3, type: :int64
  field :num_txs, 4, type: :int32
  field :last_block_id, 5, type: ABCI.Types.BlockID
  field :last_commit_hash, 6, type: :bytes
  field :data_hash, 7, type: :bytes
  field :validators_hash, 8, type: :bytes
  field :app_hash, 9, type: :bytes
end

