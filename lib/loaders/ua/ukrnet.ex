defmodule Randnews.UA.Ukrnet do
  @behaviour Randnews.SiteModule

  @url "https://www.ukr.net/api/3/section/clusters/list"

  def get(:initial) do
    @url
    |> get_by_url()
  end

  def get({:next, prev_id}) do
    @url
    |> get_by_url(%{prev_id: prev_id})
  end

  defp get_by_url(url, extra_params \\ %{}) do
    params =
      %{section_slug: "main"}
      |> Map.merge(extra_params)

    {:ok, %{headers: _h, body: body, status: 200}} =
      Randnews.JsonLoaderClient.post(url, params, headers: [{"X-Content-Language", "uk"}])

    body
  end

  def extract_news_headers(json) do
    json
    |> Map.get("data")
    |> Enum.map(fn item -> Map.get(item, "title") end)
  end

  def set_next_part_params(_current_part_params, part_data, _extracted_news_headers) do
    continue =
      part_data
      |> Map.get("has_next")

    part_params(part_data, continue)
  end

  defp part_params(_part_data, false) do
    :stop
  end

  defp part_params(part_data, true) do
    prev_id =
      part_data
      |> Map.get("data")
      |> List.last()
      |> Map.get("id")

    {:next, prev_id}
  end
end
