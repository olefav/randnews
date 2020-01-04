defmodule Randnews.Markov.Builder do
  def build_sentence(table) do
    table
    |> shuffle_table
    |> generate_sentence
  end

  def build_sentences(table, count \\ 1) do
    rand_table = table
    # |> shuffle_table # extra level of randomness (?)

    Enum.reduce(0..count, [], fn _i, sentences ->
      [generate_sentence(rand_table) | sentences]
    end)
  end

  defp shuffle_table(table) do
    table
    |> Map.new(fn {k, v} ->
      {k, Enum.shuffle(v)}
    end)
  end

  defp generate_sentence(table) do
    next_token = Enum.random(table[:start])

    generate_sentence([], table, next_token)
    |> Enum.reverse()
    |> Enum.join(" ")
  end

  defp generate_sentence(text_so_far, _table, :end) do
    text_so_far
  end

  defp generate_sentence(text_so_far, table, current_token) do
    next_token = Enum.random(table[current_token])
    generate_sentence([current_token | text_so_far], table, next_token)
  end
end
