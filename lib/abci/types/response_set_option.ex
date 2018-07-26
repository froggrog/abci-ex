defmodule ABCI.Types.ResponseSetOption do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: non_neg_integer,
          log: String.t(),
          info: String.t()
        }
  defstruct [:code, :log, :info]

  field :code, 1, type: :uint32
  field :log, 3, type: :string
  field :info, 4, type: :string
end

