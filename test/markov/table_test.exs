defmodule Randnews.Markov.TableTest do
  use ExUnit.Case

  alias Randnews.Markov.Table

  describe "generate/1" do
    test "generates a table" do
      assert Table.generate([[:start, "This", "string", :end]]) == %{
               :start => ["This"],
               "This" => ["string"],
               "string" => [:end]
             }

      assert Table.generate([[:start, "This", :end], [:start, "string", :end]]) == %{
               :start => ["string", "This"],
               "This" => [:end],
               "string" => [:end]
             }
    end
  end
end
