defmodule Randnews do
  @moduledoc """
  Documentation for Randnews.
  """

  @sites Application.get_env(:randnews, :sources)

  def dump(file_path, pages_count, sites \\ @sites) do
    File.open(file_path, [:write, encoding: :utf8], fn file ->
      data =
        Enum.reduce(sites, [], fn site, list ->
          Enum.concat(Randnews.Handler.load(site, pages_count), list)
        end)

      Enum.each(data, fn line ->
        file
        |> IO.write(line <> "\n")
      end)
    end)
  end

  def generate(file_path, sentences_count) do
    :rand.seed(:exs1024s, :os.timestamp())

    strs =
      [
        read_str_file(file_path)
      ]
      |> List.flatten()
      |> Enum.uniq()

    table =
      strs
      |> Randnews.Markov.Normalizer.normalize()
      |> Randnews.Markov.Table.generate()

    Randnews.Markov.Builder.build_sentences(table, sentences_count)
  end

  defp read_str_file(file_path) do
    File.stream!(file_path) |> Enum.map(& &1) |> Enum.map(&String.trim/1)
  end
end
