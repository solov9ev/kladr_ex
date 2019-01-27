defmodule KladrExTest do
  use ExUnit.Case
  doctest KladrEx

  import KladrEx.Helper

  alias KladrEx.Structs.QueryStruct

  describe "KladrEx.Structs.QueryStruct" do
    test "create struct with correct contentType" do
      %{contentType: content_type} = QueryStruct.new("city")
      assert content_type == "city"
    end

    test "create struct without contentType" do
      assert_raise BadArityError, &QueryStruct.new/1
    end

    test "create struct with incorrect contentType" do
      assert_raise ArgumentError, fn -> QueryStruct.new("invalid_arg") end
    end
  end

  describe "KladrEx" do
    test "make request with getting result" do
      struct =
        %QueryStruct{contentType: "building"}
        |> put_limit(3)
        |> put_zip(163_000)
        |> put_with_parent(true)

      response = KladrEx.request(endpoint(), struct)
      {:ok, %{"result" => result, "searchContext" => _search_context}} = response
      assert length(result) == 3
    end
  end
end
