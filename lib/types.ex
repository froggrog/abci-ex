defmodule ABCI.Types do
  @moduledoc """
    Get protobuf types from .proto file
  """
  @external_resource "../proto/types.proto"
  use Protobuf, from: Path.expand("../proto/types.proto", __DIR__)
  # use Protox, files: ["proto/types.proto"]
end
