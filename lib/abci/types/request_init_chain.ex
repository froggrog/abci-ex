defmodule ABCI.Types.RequestInitChain do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          validators: [ABCI.Types.Validator.t()],
          app_state_bytes: String.t()
        }
  defstruct [:validators, :app_state_bytes]

  field :validators, 1, repeated: true, type: ABCI.Types.Validator
  field :app_state_bytes, 2, type: :bytes
end

