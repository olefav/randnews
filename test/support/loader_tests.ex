defmodule Randnews.LoaderTests do
  defmacro __using__(options) do
    quote do
      use ExUnit.Case

      @moduletag unquote(options)

      test "loads news headers", %{loader: loader} do
        # loads "first page"
        some_news = Randnews.Loader.load(loader, 1)
        assert length(some_news) > 1

        # loads more
        more_news = Randnews.Loader.load(loader, length(some_news) * 2 + 1)
        assert length(more_news) > length(some_news)

        # content looks like it's at least a string with chars
        assert some_news |> List.first() |> String.match?(~r/^.+$/)
      end
    end
  end
end
