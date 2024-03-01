defmodule Randnews.UA.Pravda do
  @behaviour Randnews.SiteModule

  @initial_url "https://www.pravda.com.ua/news/"

  def get(:initial) do
    @initial_url
    |> get_by_url()
    |> parse()
  end

  def get({:next, %{page: page}}) do
    page
    |> url_for_page()
    |> get_by_url()
    |> parse()
  end

  defp get_by_url(url) do
    {:ok, %{headers: _h, body: body, status: 200}} = Tesla.get(url)
    body
  end

  defp url_for_page(page) when is_integer(page) do
    next_date = Date.utc_today() |> Date.add(-page)
    date_part = :io_lib.format('~2..0B~2..0B~4..0B', [next_date.day, next_date.month, next_date.year]) |> to_string()
    "#{@initial_url}date_#{date_part}/"
  end

  defp parse(html_body) do
    {:ok, parsed_document} = Floki.parse_document(html_body)
    parsed_document
  end

  def extract_news_headers(floki_data) do
    floki_data
    |> Floki.find(~s(.article_header > a))
    |> Enum.reduce([], fn item, acc ->
      [ process_header(item) | acc]
    end)
  end

  defp process_header({"a", _attrs, [text]}) do
    postprocess(text)
  end

  defp process_header({"a", _attrs, [{"em", _, _}, {"span", _, [text]}]}) do
    postprocess(text)
  end

  defp process_header({"a", _attrs, [{"em", _}, text]}) do
    postprocess(text)
  end

  defp process_header({"a", _attrs, [{"em", _, _}, text]}) do
    postprocess(text)
  end

  defp process_header({"a", _attrs, [{"a", _, [text, _]}]}) do
    postprocess(text)
  end

  defp postprocess(news_header_text) do
    news_header_text
    |> String.trim()
  end

  def set_next_part_params(:initial, _part_data, _extracted_news_headers) do
    {:next, %{page: 1}}
  end

  def set_next_part_params({:next, %{page: page}}, _part_data, _extracted_news_headers) do
    {:next, %{page: page + 1}}
  end
end
