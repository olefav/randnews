defmodule Randnews.Markov.Table do
  def generate(normalized_strings) do
    Enum.reduce(normalized_strings, %{}, fn s, table -> generate(table, s) end)
  end

  defp generate(table, [:end]) do
    table
  end

  defp generate(table, [first | [second | _] = next]) do
    table = add_or_update(table, first, second)
    generate(table, next)
  end

  defp add_or_update(table, key, value) do
    case Map.get(table, key) do
      nil ->
        Map.put(table, key, [value])

      existing ->
        Map.put(table, key, [value | existing])
    end
  end
end
