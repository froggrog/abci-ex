defmodule ABCI.Types.RequestBeginBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t(),
          header: ABCI.Types.Header.t(),
          absent_validators: [integer],
          byzantine_validators: [ABCI.Types.Evidence.t()]
        }
  defstruct [:hash, :header, :absent_validators, :byzantine_validators]

  field :hash, 1, type: :bytes
  field :header, 2, type: ABCI.Types.Header
  field :absent_validators, 3, repeated: true, type: :int32
  field :byzantine_validators, 4, repeated: true, type: ABCI.Types.Evidence
end
