defmodule Randnews.Markov.BuilderTest do
  use ExUnit.Case

  alias Randnews.Markov.Builder

  describe "build_sentences/2" do
    example_table = %{
      :start => ["This"],
      "This" => ["That", "That", "That", "Book"],
      "That" => [:end],
      "Book" => [:end]
    }

    # should generate ~750 "This That" and ~250 "This Book" sentences
    sentences = Builder.build_sentences(example_table, 1000)

    assert abs(Enum.count(sentences, fn s -> s == "This That" end) - 750) < 30
    assert abs(Enum.count(sentences, fn s -> s == "This Book" end) - 250) < 30
  end
end
