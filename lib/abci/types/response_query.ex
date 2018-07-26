defmodule ABCI.Types.ResponseQuery do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: non_neg_integer,
          log: String.t(),
          info: String.t(),
          index: integer,
          key: String.t(),
          value: String.t(),
          proof: String.t(),
          height: integer
        }
  defstruct [:code, :log, :info, :index, :key, :value, :proof, :height]

  field :code, 1, type: :uint32
  field :log, 3, type: :string
  field :info, 4, type: :string
  field :index, 5, type: :int64
  field :key, 6, type: :bytes
  field :value, 7, type: :bytes
  field :proof, 8, type: :bytes
  field :height, 9, type: :int64
end

