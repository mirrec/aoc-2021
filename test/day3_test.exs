defmodule Day3Test do
  use ExUnit.Case

  describe "#count" do
    test "count from example" do
      assert Day3.count(Day3.example_input()) == {22, 9, 198}
    end
  end

  describe "#count_oxygen_rate" do
    test "count from example" do
      assert Day3.count_oxygen_rate(Day3.example_input()) == 23
    end
  end

  describe "#count_co2_scrubber_rate" do
    test "count from example" do
      assert Day3.count_co2_scrubber_rate(Day3.example_input()) == 10
    end
  end

  describe "#count_life_support_rate" do
    test "count from example" do
      assert Day3.count_life_support_rate(Day3.example_input()) == 230
    end
  end
end
