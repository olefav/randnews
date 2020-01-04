defmodule Randnews.Markov.NormalizerTest do
  use ExUnit.Case

  alias Randnews.Markov.Normalizer

  describe "normalize/1" do
    test "adds markers and splits by whitespace" do
      assert Normalizer.normalize(["This string"]) == [[:start, "This", "string", :end]]

      assert Normalizer.normalize(["This", "string"]) == [
               [:start, "This", :end],
               [:start, "string", :end]
             ]

      assert Normalizer.normalize(["This is a string. Like that."]) == [
               [:start, "This", "is", "a", "string.", "Like", "that.", :end]
             ]
    end
  end
end
