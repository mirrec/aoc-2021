defmodule Day1 do
  defmodule IncreasedStep do
    def empty() do
      {false, 0}
    end

    def count_next(current_step, new_item) do
      case current_step do
        {false, _} ->
          {new_item, 0}

        {last_value, increased_count} ->
          if new_item > last_value do
            {new_item, increased_count + 1}
          else
            {new_item, increased_count}
          end
      end
    end

    def get_increased_count({_, result}) do
      result
    end
  end

  def file_stream do
    File.stream!("./priv/input/day1/input.txt")
    |> Stream.map(fn s ->
      String.trim(s)
      |> String.to_integer()
    end)
  end

  def count_simple_increasing(data) do
    increased_acc =
      Enum.reduce(
        data,
        Day1.IncreasedStep.empty(),
        fn x, step_acc ->
          Day1.IncreasedStep.count_next(step_acc, x)
        end
      )

    Day1.IncreasedStep.get_increased_count(increased_acc)
  end

  def count_batches_increasing(data) do
    {_, increased_acc} =
      Enum.reduce(
        data,
        {{}, Day1.IncreasedStep.empty()},
        fn x, {batch_acc, step_acc} ->
          case count_batch(x, batch_acc) do
            {new_item, new_batch_acc} ->
              {new_batch_acc, Day1.IncreasedStep.count_next(step_acc, new_item)}

            {new_batch_acc} ->
              {new_batch_acc, step_acc}
          end
        end
      )

    Day1.IncreasedStep.get_increased_count(increased_acc)
  end

  defp count_batch(input, acc) do
    case acc do
      {} ->
        {{input}}

      {n1} ->
        {{n1 + input, input}}

      {n2, n1} ->
        {n2 + input, {n1 + input, input}}
    end
  end

  def example_input() do
    [
      199,
      200,
      208,
      210,
      200,
      207,
      240,
      269,
      260,
      263
    ]
  end
end
