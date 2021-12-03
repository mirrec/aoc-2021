# Advent of Code 2021

https://adventofcode.com/2021

## Requirements

* elixir 1.12

## Installation

* clone repository: `git clone git@github.com:mirrec/aoc-2021.git`
* install dependencies `mix deps.get`
* run test to verify that everything runs as expected `mix test`

## Days

### Day 1

Example input

```elixir
Day1.example_input() |> Day1.count_simple_increasing() # => 7
Day1.example_input() |> Day1.count_batches_increasing() # => 5
```

File stream input

```elixir
Day1.file_stream() |> Day1.count_simple_increasing() # => :)
Day1.file_stream() |> Day1.count_batches_increasing() # => :)
```
