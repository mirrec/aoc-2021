defmodule Day1Test do
  use ExUnit.Case

  describe "#count_increasing" do
    test "empty case" do
      assert Day1.count_simple_increasing([]) == 0
    end

    test "counts how many times we increased" do
      assert Day1.count_simple_increasing(Day1.example_input()) == 7
    end
  end

  describe "#count_batches_increasing" do
    test "empty case" do
      assert Day1.count_batches_increasing([]) == 0
    end

    test "counts increasing in batches" do
      assert Day1.count_batches_increasing(Day1.example_input()) == 5
    end
  end
end
