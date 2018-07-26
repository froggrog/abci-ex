use Bitwise

defmodule ABCI.Codec do
  @moduledoc """
  Coding bytes to and from protobuf function
  """
  alias ABCI.Types
  @type abci_response :: %Types.Response{value: tuple}
  @type abci_request :: %Types.Request{value: tuple}

  @doc "Decode bytes to ABCI.Request list"
  @spec decode(binary) :: {:ok, [abci_request]}
  def decode(req, result \\ [])

  def decode(req, result) when req != "" do
    {varint, message} = varint_decode(req)

    varint_decode = zigzag_decode(varint)
    bytes = :binary.bin_to_list(message)

    tail = Enum.slice(bytes, varint_decode, length(bytes)) |> :binary.list_to_bin()
    head = Enum.slice(bytes, 0, varint_decode) |> :binary.list_to_bin()

    decode(
      tail,
      result ++ [Types.Request.decode(head)]
    )
  end

  def decode(req, result) when req == "" do
    {:ok, result}
  end

  @doc "Encode ABCI.Response list to bytes"
  @spec encode([abci_response]) :: {:ok, binary}
  def encode(responses) do
    {:ok, Enum.reduce(responses, "", fn res, bytes -> bytes <> res_to_bytes(res) end)}
  end

  @doc "Encode ABCI.Response to bytes with varint"
  @spec res_to_bytes(abci_response) :: binary
  def res_to_bytes(res) do
    bytes = Types.Response.encode(res)
    varint = String.length(bytes) |> zigzag_encode() |> varint_encode() |> IO.iodata_to_binary()
    varint <> bytes
  end

  # --- Code by Alexandre Hamez (https://github.com/ahamez)
  # --- https://github.com/EasyMile/protox
  @spec encode(integer) :: iodata
  defp varint_encode(v) when v < 128, do: <<v>>
  defp varint_encode(v), do: [<<1::1, v::7>>, varint_encode(v >>> 7)]

  @spec decode(binary) :: {non_neg_integer, binary}
  defp varint_decode(b), do: do_decode(0, 0, b)

  @spec do_decode(non_neg_integer, non_neg_integer, binary) :: {non_neg_integer, binary}
  defp do_decode(result, shift, <<0::1, byte::7, rest::binary>>) do
    {result ||| byte <<< shift, rest}
  end

  defp do_decode(result, shift, <<1::1, byte::7, rest::binary>>) do
    do_decode(
      result ||| byte <<< shift,
      shift + 7,
      rest
    )
  end

  @spec zigzag_encode(integer) :: non_neg_integer
  defp zigzag_encode(v) when v >= 0, do: v * 2
  defp zigzag_encode(v), do: v * -2 - 1

  @spec zigzag_decode(non_neg_integer) :: integer
  defp zigzag_decode(v) when (v &&& 1) == 0, do: v >>> 1
  defp zigzag_decode(v), do: -((v + 1) >>> 1)
end
