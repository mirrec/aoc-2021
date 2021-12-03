defmodule Day3 do
  defmodule Step do
    def empty() do
      {0, 0}
    end

    def count_step({zeroes, ones}, value) do
      case value do
        "0" ->
          {zeroes + 1, ones}

        "1" ->
          {zeroes, ones + 1}
      end
    end

    def pick_winner(current, on_equal \\ :equal) do
      case current do
        {zeroes, ones} when zeroes == ones ->
          on_equal

        {zeroes, ones} when zeroes > ones ->
          "0"

        {zeroes, ones} when zeroes < ones ->
          "1"
      end
    end

    def pick_looser(current, on_equal \\ :equal) do
      case current do
        {zeroes, ones} when zeroes == ones ->
          on_equal

        {zeroes, ones} when zeroes < ones ->
          "0"

        {zeroes, ones} when zeroes > ones ->
          "1"
      end
    end
  end

  def count(binaries) do
    result =
      Enum.reduce(
        binaries,
        :init,
        fn binary, acc ->
          new_acc =
            case acc do
              :init ->
                List.duplicate(Day3.Step.empty(), String.length(binary))

              _ ->
                acc
            end

          String.codepoints(binary)
          |> Enum.zip(new_acc)
          |> Enum.map(fn {letter, acc} ->
            Day3.Step.count_step(acc, letter)
          end)
        end
      )

    gamma_rate =
      Enum.map(result, &Day3.Step.pick_winner/1)
      |> steps_to_number

    epsilon_rate =
      Enum.map(result, &Day3.Step.pick_looser/1)
      |> steps_to_number

    {gamma_rate, epsilon_rate, gamma_rate * epsilon_rate}
  end

  def count_oxygen_rate(binaries) do
    count_filtered_rate(
      binaries,
      fn sum_counts -> Day3.Step.pick_winner(sum_counts, "1") end,
      0
    )
  end

  def count_co2_scrubber_rate(binaries) do
    count_filtered_rate(
      binaries,
      fn sum_counts -> Day3.Step.pick_looser(sum_counts, "0") end,
      0
    )
  end

  def count_life_support_rate(binaries) do
    count_oxygen_rate(binaries) * count_co2_scrubber_rate(binaries)
  end

  defp count_filtered_rate(binaries, keeper_fun, position) do
    filtered_binaries =
      case keeper_fun.(sum_occurrence_at_position(binaries, position)) do
        "1" ->
          keep_binaries_with_value_on_position(binaries, "1", position)

        "0" ->
          keep_binaries_with_value_on_position(binaries, "0", position)
      end

    case filtered_binaries do
      [one] ->
        String.to_integer(one, 2)

      _ ->
        count_filtered_rate(filtered_binaries, keeper_fun, position + 1)
    end
  end

  defp keep_binaries_with_value_on_position(binaries, value, position) do
    Enum.filter(binaries, fn binary -> String.at(binary, position) == value end)
  end

  defp sum_occurrence_at_position(binaries, position) do
    Enum.reduce(
      binaries,
      Day3.Step.empty(),
      fn binary, acc ->
        Day3.Step.count_step(acc, String.at(binary, position))
      end
    )
  end

  defp steps_to_number(steps) do
    Enum.join(steps, "")
    |> String.to_integer(2)
  end

  def example_input() do
    [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010"
    ]
  end

  def file_stream do
    File.stream!("./priv/input/day3/input.txt")
    |> Stream.map(fn s ->
      String.trim(s)
    end)
  end
end
