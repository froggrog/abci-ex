defmodule ABCI.Types.RequestCheckTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: String.t()
        }
  defstruct [:tx]

  field :tx, 1, type: :bytes
end

