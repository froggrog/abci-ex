defmodule ABCI.Types.RequestEndBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: integer
        }
  defstruct [:height]

  field :height, 1, type: :int64
end

