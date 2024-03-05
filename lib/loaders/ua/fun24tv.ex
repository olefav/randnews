defmodule Randnews.UA.Fun24tv do
  @behaviour Randnews.SiteModule

  @url "https://api.24tv.ua/news/list"
  @news_part_count 20

  def get(:initial) do
    get_content()
  end

  def get({:next, last_end_date}) do
    get_content(last_end_date)
  end

  defp get_content(end_date \\ :initial) do
    params =
      "?siteId=26&startRow=1&importantOnly=false&rowsCount=#{@news_part_count}&blockKey=LAST_NEWS_BLOCK&fields=news%5Bid,newsUrlUk,name,publishedDate%5D&fromDate=#{get_news_end_date(end_date)}&lang=uk"

    {:ok, %{headers: _h, body: body, status: 200}} =
      Randnews.JsonLoaderClient.get(@url <> params,
        headers: [{"Referer", " https://fun.24tv.ua/"}]
      )

    body
  end

  defp get_news_end_date(:initial) do
    DateTime.utc_now()
    |> DateTime.truncate(:second)
    |> DateTime.to_string()
    |> String.replace("Z", "")
    |> String.replace("-", "/")
    |> String.replace(" ", "%20")
  end

  defp get_news_end_date(date_string) do
    date_string
    |> String.replace(" ", "%20")
  end

  def extract_news_headers(json) do
    json
    |> Map.get("news")
    |> Enum.map(fn item -> Map.get(item, "name") end)
  end

  def set_next_part_params(_current_part_params, part_data, _extracted_news_headers) do
    last_news_item_published =
      part_data
      |> Map.get("news")
      |> List.last()
      |> Map.get("publishedDate")

    {:next, last_news_item_published}
  end
end
