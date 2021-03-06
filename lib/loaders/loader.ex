defmodule Randnews.Loader do
  @callback base_url() :: String.t()
  @callback page_path_modifier(integer) :: String.t()

  def get(impl) do
    get(impl, 0)
  end

  def get(impl, page_number) do
    {:ok, %{headers: h, body: b}} =
      Tesla.get(impl.base_url <> impl.page_path_modifier(page_number))

    process_content_type(get_content_type(h), b)
  end

  defp get_content_type(headers) do
    Enum.into(headers, %{})["content-type"] |> String.downcase()
  end

  defp process_content_type("text/html", body) do
    body
  end

  defp process_content_type("text/html; charset=utf-8", body) do
    body
  end

  defp process_content_type("text/html; charset=windows-1251", body) do
    :iconv.convert("windows-1251", "utf-8", body)
  end
end
