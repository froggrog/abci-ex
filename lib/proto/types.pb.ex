defmodule ABCI.Types.KVPair do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :bytes
  field :value, 2, type: :bytes
end

defmodule ABCI.Types.KI64Pair do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: integer
        }
  defstruct [:key, :value]

  field :key, 1, type: :bytes
  field :value, 2, type: :int64
end

defmodule ABCI.Types.Request do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof :value, 0
  field :echo, 2, type: ABCI.Types.RequestEcho, oneof: 0
  field :flush, 3, type: ABCI.Types.RequestFlush, oneof: 0
  field :info, 4, type: ABCI.Types.RequestInfo, oneof: 0
  field :set_option, 5, type: ABCI.Types.RequestSetOption, oneof: 0
  field :init_chain, 6, type: ABCI.Types.RequestInitChain, oneof: 0
  field :query, 7, type: ABCI.Types.RequestQuery, oneof: 0
  field :begin_block, 8, type: ABCI.Types.RequestBeginBlock, oneof: 0
  field :check_tx, 9, type: ABCI.Types.RequestCheckTx, oneof: 0
  field :deliver_tx, 19, type: ABCI.Types.RequestDeliverTx, oneof: 0
  field :end_block, 11, type: ABCI.Types.RequestEndBlock, oneof: 0
  field :commit, 12, type: ABCI.Types.RequestCommit, oneof: 0
end

defmodule ABCI.Types.RequestEcho do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          message: String.t()
        }
  defstruct [:message]

  field :message, 1, type: :string
end

defmodule ABCI.Types.RequestFlush do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ABCI.Types.RequestInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          version: String.t()
        }
  defstruct [:version]

  field :version, 1, type: :string
end

defmodule ABCI.Types.RequestSetOption do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

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

defmodule ABCI.Types.RequestQuery do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          data: String.t(),
          path: String.t(),
          height: integer,
          prove: boolean
        }
  defstruct [:data, :path, :height, :prove]

  field :data, 1, type: :bytes
  field :path, 2, type: :string
  field :height, 3, type: :int64
  field :prove, 4, type: :bool
end

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

defmodule ABCI.Types.RequestCheckTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: String.t()
        }
  defstruct [:tx]

  field :tx, 1, type: :bytes
end

defmodule ABCI.Types.RequestDeliverTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: String.t()
        }
  defstruct [:tx]

  field :tx, 1, type: :bytes
end

defmodule ABCI.Types.RequestEndBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: integer
        }
  defstruct [:height]

  field :height, 1, type: :int64
end

defmodule ABCI.Types.RequestCommit do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ABCI.Types.Response do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof :value, 0
  field :exception, 1, type: ABCI.Types.ResponseException, oneof: 0
  field :echo, 2, type: ABCI.Types.ResponseEcho, oneof: 0
  field :flush, 3, type: ABCI.Types.ResponseFlush, oneof: 0
  field :info, 4, type: ABCI.Types.ResponseInfo, oneof: 0
  field :set_option, 5, type: ABCI.Types.ResponseSetOption, oneof: 0
  field :init_chain, 6, type: ABCI.Types.ResponseInitChain, oneof: 0
  field :query, 7, type: ABCI.Types.ResponseQuery, oneof: 0
  field :begin_block, 8, type: ABCI.Types.ResponseBeginBlock, oneof: 0
  field :check_tx, 9, type: ABCI.Types.ResponseCheckTx, oneof: 0
  field :deliver_tx, 10, type: ABCI.Types.ResponseDeliverTx, oneof: 0
  field :end_block, 11, type: ABCI.Types.ResponseEndBlock, oneof: 0
  field :commit, 12, type: ABCI.Types.ResponseCommit, oneof: 0
end

defmodule ABCI.Types.ResponseException do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          error: String.t()
        }
  defstruct [:error]

  field :error, 1, type: :string
end

defmodule ABCI.Types.ResponseEcho do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          message: String.t()
        }
  defstruct [:message]

  field :message, 1, type: :string
end

defmodule ABCI.Types.ResponseFlush do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

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

defmodule ABCI.Types.ResponseInitChain do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

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

defmodule ABCI.Types.ResponseBeginBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ABCI.Types.ResponseCheckTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: non_neg_integer,
          data: String.t(),
          log: String.t(),
          info: String.t(),
          gas_wanted: integer,
          gas_used: integer,
          tags: [ABCI.Types.KVPair.t()],
          fee: ABCI.Types.KI64Pair.t()
        }
  defstruct [:code, :data, :log, :info, :gas_wanted, :gas_used, :tags, :fee]

  field :code, 1, type: :uint32
  field :data, 2, type: :bytes
  field :log, 3, type: :string
  field :info, 4, type: :string
  field :gas_wanted, 5, type: :int64
  field :gas_used, 6, type: :int64
  field :tags, 7, repeated: true, type: ABCI.Types.KVPair
  field :fee, 8, type: ABCI.Types.KI64Pair
end

defmodule ABCI.Types.ResponseDeliverTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: non_neg_integer,
          data: String.t(),
          log: String.t(),
          info: String.t(),
          gas_wanted: integer,
          gas_used: integer,
          tags: [ABCI.Types.KVPair.t()],
          fee: ABCI.Types.KI64Pair.t()
        }
  defstruct [:code, :data, :log, :info, :gas_wanted, :gas_used, :tags, :fee]

  field :code, 1, type: :uint32
  field :data, 2, type: :bytes
  field :log, 3, type: :string
  field :info, 4, type: :string
  field :gas_wanted, 5, type: :int64
  field :gas_used, 6, type: :int64
  field :tags, 7, repeated: true, type: ABCI.Types.KVPair
  field :fee, 8, type: ABCI.Types.KI64Pair
end

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

defmodule ABCI.Types.ResponseCommit do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          data: String.t()
        }
  defstruct [:data]

  field :data, 2, type: :bytes
end

defmodule ABCI.Types.ConsensusParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_size: ABCI.Types.BlockSize.t(),
          tx_size: ABCI.Types.TxSize.t(),
          block_gossip: ABCI.Types.BlockGossip.t()
        }
  defstruct [:block_size, :tx_size, :block_gossip]

  field :block_size, 1, type: ABCI.Types.BlockSize
  field :tx_size, 2, type: ABCI.Types.TxSize
  field :block_gossip, 3, type: ABCI.Types.BlockGossip
end

defmodule ABCI.Types.BlockSize do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          max_bytes: integer,
          max_txs: integer,
          max_gas: integer
        }
  defstruct [:max_bytes, :max_txs, :max_gas]

  field :max_bytes, 1, type: :int32
  field :max_txs, 2, type: :int32
  field :max_gas, 3, type: :int64
end

defmodule ABCI.Types.TxSize do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          max_bytes: integer,
          max_gas: integer
        }
  defstruct [:max_bytes, :max_gas]

  field :max_bytes, 1, type: :int32
  field :max_gas, 2, type: :int64
end

defmodule ABCI.Types.BlockGossip do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_part_size_bytes: integer
        }
  defstruct [:block_part_size_bytes]

  field :block_part_size_bytes, 1, type: :int32
end

defmodule ABCI.Types.Header do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          chain_id: String.t(),
          height: integer,
          time: integer,
          num_txs: integer,
          last_block_id: ABCI.Types.BlockID.t(),
          last_commit_hash: String.t(),
          data_hash: String.t(),
          validators_hash: String.t(),
          app_hash: String.t()
        }
  defstruct [
    :chain_id,
    :height,
    :time,
    :num_txs,
    :last_block_id,
    :last_commit_hash,
    :data_hash,
    :validators_hash,
    :app_hash
  ]

  field :chain_id, 1, type: :string
  field :height, 2, type: :int64
  field :time, 3, type: :int64
  field :num_txs, 4, type: :int32
  field :last_block_id, 5, type: ABCI.Types.BlockID
  field :last_commit_hash, 6, type: :bytes
  field :data_hash, 7, type: :bytes
  field :validators_hash, 8, type: :bytes
  field :app_hash, 9, type: :bytes
end

defmodule ABCI.Types.BlockID do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t(),
          parts: ABCI.Types.PartSetHeader.t()
        }
  defstruct [:hash, :parts]

  field :hash, 1, type: :bytes
  field :parts, 2, type: ABCI.Types.PartSetHeader
end

defmodule ABCI.Types.PartSetHeader do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          total: integer,
          hash: String.t()
        }
  defstruct [:total, :hash]

  field :total, 1, type: :int32
  field :hash, 2, type: :bytes
end

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
