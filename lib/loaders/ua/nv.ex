defmodule Randnews.UA.Nv do
  @behaviour Randnews.SiteModule

  @initial_url "https://nv.ua/ukr/allnews.html"

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
    @initial_url <> "?page=#{page}"
  end

  defp parse(html_body) do
    {:ok, parsed_document} = Floki.parse_document(html_body)
    parsed_document
  end

  def extract_news_headers(floki_data) do
    floki_data
    |> Floki.find(~s(div.title))
    |> Enum.reduce([], fn {_el, _attrs, [text]}, acc ->
      [String.trim(text) | acc]
    end)
  end

  def set_next_part_params(:initial, _part_data, _extracted_news_headers) do
    {:next, %{page: 1}}
  end

  def set_next_part_params({:next, %{page: page}}, _part_data, _extracted_news_headers) do
    {:next, %{page: page + 1}}
  end
end
