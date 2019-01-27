defmodule KladrEx do
  @moduledoc """
  Documentation for KladrEx.
  """

  alias KladrEx.Structs.QueryStruct

  @spec request(String.t(), QueryStruct.t()) :: {atom(), String.t()} | {atom(), map()}
  def request(endpoint, %QueryStruct{} = struct) when is_bitstring(endpoint) do
    case HTTPoison.get!(endpoint, [], params: Map.from_struct(struct)) do
      %HTTPoison.Response{body: body, status_code: 200} ->
        Poison.decode(body)

      _ ->
        {:error, "Invalid request"}
    end
  end
end
