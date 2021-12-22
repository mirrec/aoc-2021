defmodule Aoc.Day4 do
  defmodule Board do
    defstruct [:rows, :drawn_row_map, :drawn_column_map, :draws_sum, :done]

    def board_size do
      5
    end

    def new(rows) do
      %__MODULE__{
        rows: rows,
        drawn_row_map: %{},
        drawn_column_map: %{},
        draws_sum: 0,
        done: false
      }
    end

    def draw(%__MODULE__{done: true} = current, _) do
      current
    end

    def draw(%__MODULE__{} = current, drawn_number) do
      case find_number(current, drawn_number) do
        {true, {row_index, column_index}} ->
          {new_row_map, row_index, drawn_in_row} =
            add_to_2d_index_map(current.drawn_row_map, row_index, column_index)

          {new_column_map, column_index, drawn_in_column} =
            add_to_2d_index_map(
              current.drawn_column_map,
              column_index,
              row_index
            )

          new_current = %{
            current
            | draws_sum: current.draws_sum + drawn_number,
              drawn_row_map: new_row_map,
              drawn_column_map: new_column_map
          }

          size = board_size()

          case {drawn_in_row, drawn_in_column} do
            {^size, _} ->
              {:bingo, %{new_current | done: true}, :row, row_index}

            {_, ^size} ->
              {:bingo, %{new_current | done: true}, :column, column_index}

            _ ->
              new_current
          end

        false ->
          current
      end
    end

    def draw_with_bingo_result(%__MODULE__{} = current, drawn_number) do
      case draw(current, drawn_number) do
        {:bingo, new_current, _, _} ->
          {:bingo, (sum(new_current) - new_current.draws_sum) * drawn_number, new_current}

        new_current ->
          new_current
      end
    end

    def find_number(%__MODULE__{rows: rows}, number_to_be_found) do
      result =
        Enum.reduce(
          rows,
          {false, 0},
          fn row, acc ->
            case acc do
              {true, _} ->
                acc

              {false, row_index} ->
                case Enum.find_index(row, fn value -> value == number_to_be_found end) do
                  nil ->
                    {false, row_index + 1}

                  column_index ->
                    {true, {row_index, column_index}}
                end
            end
          end
        )

      case result do
        {true, _} ->
          result

        {false, _} ->
          false
      end
    end

    def sum(%__MODULE__{rows: rows}) do
      Enum.reduce(rows, 0, fn row, acc -> acc + Enum.sum(row) end)
    end

    defp add_to_2d_index_map(%{} = map, x_index, y_index) do
      inside_map = Map.get(map, x_index, %{})
      new_inside_map = Map.put(inside_map, y_index, true)
      new_map = Map.put(map, x_index, new_inside_map)
      {new_map, x_index, map_size(new_inside_map)}
    end
  end

  def main_part_1(string_input) do
    {draws, boards} = parse_input(string_input)

    winners =
      Enum.reduce_while(
        draws,
        {nil, boards},
        fn number, acc ->
          case acc do
            {nil, boards} ->
              case draw_step_first_winner(number, boards) do
                {[], new_boards} ->
                  {:cont, {nil, new_boards}}

                {winners, _} ->
                  {:halt, winners}
              end
          end
        end
      )

    winners
  end

  defp draw_step_first_winner(number, boards) do
    {winners, new_boards} =
      Enum.reduce(
        boards,
        {[], []},
        fn board, {winners, new_boards} ->
          case Aoc.Day4.Board.draw_with_bingo_result(board, number) do
            {:bingo, winner, new_board} ->
              {[winner | winners], [new_board | new_boards]}

            new_board ->
              {winners, [new_board | new_boards]}
          end
        end
      )

    {Enum.reverse(winners), Enum.reverse(new_boards)}
  end

  def main_part_2(string_input) do
    {draws, boards} = parse_input(string_input)

    winners =
      Enum.reduce_while(
        draws,
        {length(boards), boards},
        fn number, acc ->
          case acc do
            {pending_winners_count, boards} ->
              case draw_step_first_winner(number, boards) do
                {winners_scores, new_boards} ->
                  case pending_winners_count - length(winners_scores) do
                    0 ->
                      {:halt, winners_scores}

                    new_pending ->
                      {:cont, {new_pending, new_boards}}
                  end
              end
          end
        end
      )

    winners
  end

  defp parse_input(string_input) do
    [draws_input | boards_input] = String.split(string_input, "\n", trim: true)

    {
      parse_drawn(draws_input),
      parse_boards(boards_input)
    }
  end

  defp parse_drawn(string_input) do
    string_input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_boards(string_input) do
    string_input
    |> Enum.map(&parse_board_line/1)
    |> Enum.chunk_every(Aoc.Day4.Board.board_size())
    |> Enum.map(&Aoc.Day4.Board.new/1)
  end

  defp parse_board_line(string_input) do
    string_input
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def example_input do
    "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
"
  end

  def file_input do
    File.read!("./priv/input/day4/input.txt")
  end
end
