defmodule Randnews.Markov.Normalizer do
  def normalize(string_list) do
    Enum.map(string_list, &normalize_string/1)
  end

  defp normalize_string(str) do
    [:start] ++ String.split(str, " ") ++ [:end]
  end
end
