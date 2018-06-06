# Elixir ABCI
An Elixir implementation of the ABCI protocol for Tendermint.

## About abci-ex
This library implements the ABCI protocol and can be used to write ABCI applications for Tendermint in Elixir.
Here you can find more information about [Tendermint](https://github.com/tendermint/tendermint) and [ABCI application](https://github.com/tendermint/abci).

## Installation
Add `:abci` as a dependency to your project's `mix.exs`:

```elixir
defp deps do
  [
    {:abci, git: "https://github.com/neocortexlab/abci-ex.git", tag: "0.1"}
  ]
end
```

And run:

    $ mix deps.get


## Counter example 
Clone this repository and run:

    $ iex -S mix

Start ABCI Server with Counter App

```elixir
iex> ABCI.Example.CounterApp.init
```

For testing use [abci-cli](https://github.com/tendermint/abci).

    $ abci-cli test

Here you can find more information about [Counter example](https://tendermint.readthedocs.io/en/master/abci-cli.html)