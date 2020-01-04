defmodule Randnews.Parser do
  def extract_news_headers(news_html, impl) do
    {:ok, parsed_html} = Floki.parse_document(news_html)

    parsed_html
    |> Floki.find(impl.news_headers_css)
    |> Enum.reduce([], fn header, acc ->
      [impl.extract_text_from_header(header) |> String.trim() | acc]
    end)
    |> Enum.reverse()
  end

  @callback extract_text_from_header(any) :: String.t()
  @callback news_headers_css() :: String.t()
end
