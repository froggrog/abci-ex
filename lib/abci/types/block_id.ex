defmodule ABCI.Types.BlockID do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t(),
          parts: ABCI.Types.PartSetHeader.t()
        }
  defstruct [:hash, :parts]

  field :hash, 1, type: :bytes
  field :parts, 2, type: ABCI.Types.PartSetHeader
end

