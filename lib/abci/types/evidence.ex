defmodule ABCI.Types.Evidence do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pub_key: String.t(),
          height: integer
        }
  defstruct [:pub_key, :height]

  field :pub_key, 1, type: :bytes
  field :height, 2, type: :int64
end
