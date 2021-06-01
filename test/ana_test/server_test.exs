defmodule AnaTest.Server do
  use ExUnit.Case
  doctest Ana.Server

  describe "Server is running properly" do
    test "greets the world" do
      assert Ana.hello() == :world
    end
  end
end
