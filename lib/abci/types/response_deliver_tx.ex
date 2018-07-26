defmodule ABCI.Types.ResponseDeliverTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: non_neg_integer,
          data: String.t(),
          log: String.t(),
          info: String.t(),
          gas_wanted: integer,
          gas_used: integer,
          tags: [ABCI.Types.KVPair.t()],
          fee: ABCI.Types.KI64Pair.t()
        }
  defstruct [:code, :data, :log, :info, :gas_wanted, :gas_used, :tags, :fee]

  field :code, 1, type: :uint32
  field :data, 2, type: :bytes
  field :log, 3, type: :string
  field :info, 4, type: :string
  field :gas_wanted, 5, type: :int64
  field :gas_used, 6, type: :int64
  field :tags, 7, repeated: true, type: ABCI.Types.KVPair
  field :fee, 8, type: ABCI.Types.KI64Pair
end

