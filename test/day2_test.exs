defmodule Day2Test do
  use ExUnit.Case

  describe "#count_simple" do
    test "empty case" do
      assert Day2.count_simple([]) == %{horizontal: 0, depth: 0, result: 0}
    end

    test "counts with example" do
      assert Day2.count_simple(Day2.example_input()) == %{horizontal: 15, depth: 10, result: 150}
    end
  end

  describe "#count_with_aim" do
    test "empty case" do
      assert Day2.count_with_aim([]) == {
               %Day2.PositionAim{horizontal: 0, depth: 0, aim: 0},
               0
             }
    end

    test "counts with example" do
      assert Day2.count_with_aim(Day2.example_input()) == {
               %Day2.PositionAim{horizontal: 15, depth: 60, aim: 10},
               900
             }
    end
  end
end
