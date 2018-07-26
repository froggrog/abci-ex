defmodule ABCI.Types.KI64Pair do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: integer
        }
  defstruct [:key, :value]

  field :key, 1, type: :bytes
  field :value, 2, type: :int64
end
