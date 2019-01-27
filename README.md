# KladrEx

**API interaction library with the Kladr-API service.**
1. Add environment keys to the operating system: `KLADR_EX_ENDPOINT`, `KLADR_EX_TOKEN` or config file:
```elixir
config :kladr_ex,
	endpoint: "endpoint", 
	token: "token"
```

2.  Perform a test: `mix test`

3. Use library:
```elixir
import KladrEx.Helper
alias KladrEx.Structs.QueryStruct
struct = 
	%QueryStruct{contentType: "building"}
	|> put_limit(3)
	|> put_zip(163_000)
	|> put_with_parent(true)
	
	response = KladrEx.request(endpoint(), struct)
```

## Installation

The package can be installed by adding `kladr_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:kladr_ex, git: "git://github.com/solov9ev/kladr_ex.git"}
  ]
end
```