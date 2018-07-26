defmodule ABCI.Types.ResponseEndBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          validator_updates: [ABCI.Types.Validator.t()],
          consensus_param_updates: ABCI.Types.ConsensusParams.t()
        }
  defstruct [:validator_updates, :consensus_param_updates]

  field :validator_updates, 1, repeated: true, type: ABCI.Types.Validator
  field :consensus_param_updates, 2, type: ABCI.Types.ConsensusParams
end

