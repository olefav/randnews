defmodule Randnews do
  @moduledoc """
  Documentation for Randnews.
  """

  @sites Application.compile_env(:randnews, :sources)

  def dump(file_path, news_count, sites \\ @sites) do
    File.open(file_path, [:write, encoding: :utf8], fn file ->
      stream =
        Task.async_stream(sites, fn site ->
          Randnews.Handler.load(site, news_count)
        end)

      data =
        stream
        |> Enum.reduce([], fn {:ok, news}, list -> Enum.concat(news, list) end)

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
