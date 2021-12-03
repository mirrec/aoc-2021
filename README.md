# Advent of Code 2021

https://adventofcode.com/2021

## Requirements

* elixir 1.12

## Installation

* clone repository: `git clone git@github.com:mirrec/aoc-2021.git`
* install dependencies `mix deps.get`
* run test to verify that everything runs as expected `mix test`

## Days

Every day contains an `example_input` and a `file_stream` input. Both can be use to test or get the result. Example:
* `Day1.example_input()`
* `Day1.file_stream()`

### Day 1

```elixir
Day1.example_input() |> Day1.count_simple_increasing() # => 7
Day1.example_input() |> Day1.count_batches_increasing() # => 5
```

### Day 2

```elixir
Day2.example_input() |> Day2.count_simple() # => %{horizontal: 15, depth: 10, result: 150}
Day2.example_input() |> Day2.count_with_aim() # => {%Day2.PositionAim{horizontal: 15, depth: 60, aim: 10}, 900}
```

### Day 3

```elixir
Day3.example_input() |> Day3.count() # {22, 9, 198}
Day3.example_input() |> Day3.count_life_support_rate() # 230
```
