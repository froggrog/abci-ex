defmodule CodecTest do
  use ExUnit.Case
  doctest ABCI.Codec

  test "ABCI Client send Request.RequestEcho{message: \"Hello\"}" do
    bytes = <<18, 18, 7, 10, 5, 104, 101, 108, 108, 111>>

    assert ABCI.Codec.decode(bytes) ==
             {:ok,
              [
                %ABCI.Types.Request{
                  value: {:echo, %ABCI.Types.RequestEcho{message: "hello"}}
                }
              ]}
  end

  test "ABCI Client send Request.RequestDeliverTx end Request.RequestEndBlock" do
    bytes = <<12, 154, 1, 3, 10, 1, 0, 8, 90, 2, 8, 2>>

    assert ABCI.Codec.decode(bytes) ==
             {:ok,
              [
                %ABCI.Types.Request{
                  value: {:deliver_tx, %ABCI.Types.RequestDeliverTx{tx: <<0>>}}
                },
                %ABCI.Types.Request{
                  value: {:end_block, %ABCI.Types.RequestEndBlock{height: 2}}
                }
              ]}
  end
end
