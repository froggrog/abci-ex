defmodule ABCI.Types.ResponseCommit do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          data: String.t()
        }
  defstruct [:data]

  field :data, 2, type: :bytes
end

