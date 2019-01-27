defmodule KladrEx.Helper do
  alias KladrEx.Structs.QueryStruct

  @endpoint_key "KLADR_EX_ENDPOINT"
  @token_key "KLADR_EX_TOKEN"

  @spec put_parent_type(QueryStruct.t(), String.t()) :: QueryStruct.t()
  def put_parent_type(%QueryStruct{} = struct, parent_type)
      when is_bitstring(parent_type) do
    %{struct | parentType: parent_type}
  end

  @spec put_parent_id(QueryStruct.t(), String.t()) :: QueryStruct.t()
  def put_parent_id(%QueryStruct{} = struct, parent_id)
      when is_bitstring(parent_id) do
    %{struct | parentId: parent_id}
  end

  @spec put_content_type(QueryStruct.t(), String.t()) :: QueryStruct.t()
  def put_content_type(%QueryStruct{} = struct, content_type)
      when is_bitstring(content_type) do
    QueryStruct.validate_content_type(content_type)

    %{struct | contentType: content_type}
  end

  @spec put_content_name(QueryStruct.t(), String.t()) :: QueryStruct.t()
  def put_content_name(%QueryStruct{} = struct, content_name)
      when is_bitstring(content_name) do
    %{struct | contentName: content_name}
  end

  @spec put_with_parent(QueryStruct.t(), integer()) :: QueryStruct.t()
  def put_with_parent(%QueryStruct{} = struct, with_parent)
      when is_integer(with_parent) or is_boolean(with_parent) do
    %{struct | withParent: with_parent}
  end

  @spec put_zip(QueryStruct.t(), integer()) :: QueryStruct.t()
  def put_zip(%QueryStruct{} = struct, zip) when is_integer(zip) do
    %{struct | zip: zip}
  end

  @spec put_limit(QueryStruct.t(), integer()) :: QueryStruct.t()
  def put_limit(%QueryStruct{} = struct, limit) when is_integer(limit) do
    %{struct | limit: limit}
  end

  @spec put_offset(QueryStruct.t(), integer()) :: QueryStruct.t()
  def put_offset(%QueryStruct{} = struct, offset) when is_integer(offset) do
    %{struct | offset: offset}
  end

  @spec put_token(QueryStruct.t()) :: QueryStruct.t()
  def put_token(%QueryStruct{} = struct) do
    case token() do
      nil -> struct
      token -> %{struct | token: token}
    end
  end

  @spec endpoint() :: String.t() | nil
  def endpoint(), do: get_env_value(@endpoint_key)

  @spec token() :: String.t() | nil
  def token(), do: get_env_value(@token_key)

  @spec get_env_value(String.t()) :: String.t() | no_return
  defp get_env_value(key) do
    case System.get_env(key) do
      nil ->
        key =
          key
          |> String.split("_")
          |> List.last()
          |> String.downcase()
          |> String.to_atom()

        Application.get_env(:kladr_ex, key)

      value ->
        value
    end
  end
end
