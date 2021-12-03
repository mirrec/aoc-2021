defmodule Day2 do
  defmodule Position do
    def empty() do
      {0, 0}
    end

    def count_step({horizontal, depth}, instruction) do
      case instruction do
        {"forward", value} ->
          {horizontal + value, depth}

        {"down", value} ->
          {horizontal, depth + value}

        {"up", value} ->
          {horizontal, depth - value}
      end
    end

    def result({horizontal, depth}) do
      %{horizontal: horizontal, depth: depth, result: horizontal * depth}
    end
  end

  defmodule PositionAim do
    defstruct [:horizontal, :depth, :aim]

    def empty() do
      %__MODULE__{horizontal: 0, depth: 0, aim: 0}
    end

    def count_step(
          %__MODULE__{horizontal: horizontal, depth: depth, aim: aim} = current,
          instruction
        ) do
      case instruction do
        {"forward", value} ->
          %{current | horizontal: horizontal + value, depth: depth + aim * value}

        {"down", value} ->
          %{current | aim: current.aim + value}

        {"up", value} ->
          %{current | aim: current.aim - value}
      end
    end

    def result(%__MODULE__{horizontal: horizontal, depth: depth} = current) do
      {
        current,
        horizontal * depth
      }
    end
  end

  def file_stream do
    File.stream!("./priv/input/day2/input.txt")
    |> Stream.map(fn s ->
      String.trim(s)
    end)
  end

  def count_simple(instructions) do
    count(instructions, Day2.Position)
  end

  def count_with_aim(instructions) do
    count(instructions, Day2.PositionAim)
  end

  defp count(instructions, module) do
    result =
      Enum.reduce(instructions, module.empty(), fn instruction, position ->
        module.count_step(position, parse_instruction(instruction))
      end)

    module.result(result)
  end

  def parse_instruction(string) do
    case String.split(string, " ") do
      [instruction, number_in_string] ->
        {instruction, String.to_integer(number_in_string)}
    end
  end

  def example_input() do
    [
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2"
    ]
  end
end
