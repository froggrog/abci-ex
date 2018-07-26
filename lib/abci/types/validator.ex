defmodule ABCI.Types.Validator do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pub_key: String.t(),
          power: integer
        }
  defstruct [:pub_key, :power]

  field :pub_key, 1, type: :bytes
  field :power, 2, type: :int64
end

