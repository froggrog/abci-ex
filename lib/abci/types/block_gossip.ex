defmodule ABCI.Types.BlockGossip do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_part_size_bytes: integer
        }
  defstruct [:block_part_size_bytes]

  field :block_part_size_bytes, 1, type: :int32
end

