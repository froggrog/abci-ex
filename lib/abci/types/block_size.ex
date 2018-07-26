defmodule ABCI.Types.BlockSize do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          max_bytes: integer,
          max_txs: integer,
          max_gas: integer
        }
  defstruct [:max_bytes, :max_txs, :max_gas]

  field :max_bytes, 1, type: :int32
  field :max_txs, 2, type: :int32
  field :max_gas, 3, type: :int64
end

