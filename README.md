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

### Day 2

Example input

```elixir
Day2.example_input() |> Day2.count_simple() # => %{horizontal: 15, depth: 10, result: 150}
Day2.example_input() |> Day2.count_with_aim() # => {%Day2.PositionAim{horizontal: 15, depth: 60, aim: 10}, 900}
```

File stream input

```elixir
Day2.file_stream() |> Day2.count_simple() # => :)
Day2.file_stream() |> Day2.count_with_aim() # => :)
```
