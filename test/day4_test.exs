defmodule Aoc.Day4Test do
  use ExUnit.Case

  alias Aoc.Day4
  alias Aoc.Day4.Board

  @board_rows [
    [22, 13, 17, 11, 0],
    [8, 2, 23, 4, 24],
    [21, 9, 14, 16, 7],
    [6, 10, 3, 18, 5],
    [1, 12, 20, 15, 19]
  ]

  describe "part 1" do
    test "board find" do
      board = Board.new(@board_rows)
      assert Board.find_number(board, 22) == {true, {0, 0}}
      assert Board.find_number(board, 0) == {true, {0, 4}}
      assert Board.find_number(board, 1) == {true, {4, 0}}
      assert Board.find_number(board, 19) == {true, {4, 4}}
      assert Board.find_number(board, 3) == {true, {3, 2}}

      assert Board.find_number(board, 999) == false
    end

    test "board draw" do
      board = Board.new(@board_rows)
      row_bingo_drawn = [8, 2, 23, 4, 24]

      {:bingo, _, :row, 1} =
        Enum.reduce(row_bingo_drawn, board, fn number, acc ->
          Board.draw(acc, number)
        end)

      column_bingo_drawn = [11, 4, 16, 18, 15]

      {:bingo, _, :column, 3} =
        Enum.reduce(column_bingo_drawn, board, fn number, acc ->
          Board.draw(acc, number)
        end)
    end

    test "board draw_with_bingo_result" do
      board =
        Board.new([
          [14, 21, 17, 24, 4],
          [10, 16, 15, 9, 19],
          [18, 8, 23, 26, 20],
          [22, 11, 13, 6, 5],
          [2, 0, 12, 3, 7]
        ])

      draws = [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24]

      {:bingo, 4512, _} =
        Enum.reduce(draws, board, fn number, acc ->
          Board.draw_with_bingo_result(acc, number)
        end)
    end

    test "main example" do
      result =
        Day4.example_input()
        |> Day4.main()

      assert result == [4512]
    end
  end
end
