defmodule ABCI.Types.ResponseInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          data: String.t(),
          version: String.t(),
          last_block_height: integer,
          last_block_app_hash: String.t()
        }
  defstruct [:data, :version, :last_block_height, :last_block_app_hash]

  field :data, 1, type: :string
  field :version, 2, type: :string
  field :last_block_height, 3, type: :int64
  field :last_block_app_hash, 4, type: :bytes
end

