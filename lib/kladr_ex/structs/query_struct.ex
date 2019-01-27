defmodule KladrEx.Structs.QueryStruct do
  @moduledoc """
  Query struct for KladrEx.
  """

  @enforce_keys [:contentType]
  @content_types ["region", "district", "city", "city", "building"]

  defstruct [
    :parentType,
    :parentId,
    :contentType,
    :contentName,
    :withParent,
    :zip,
    :limit,
    :offset
  ]

  @type t :: %__MODULE__{
          parentType: String.t(),
          parentId: String.t(),
          contentType: String.t(),
          contentName: String.t(),
          withParent: integer,
          zip: integer,
          limit: integer,
          offset: integer
        }

  @spec new(String.t()) :: %__MODULE__{contentType: String.t()}
  def new(content_type) when is_bitstring(content_type) do
    validate_content_type(content_type)

    %__MODULE__{contentType: content_type}
  end

  @spec validate_content_type(String.t()) :: nil
  def validate_content_type(content_type) do
    unless Enum.member?(@content_types, content_type) do
      raise ArgumentError, message: "invalid argument content_type"
    end
  end

  @spec content_types() :: [String.t()]
  def content_types, do: @content_types
end
