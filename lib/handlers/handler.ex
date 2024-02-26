defmodule Randnews.Handler do
  def load(site, page_count \\ 1) do
    tasks =
      Enum.reduce(1..page_count, [], fn i, acc ->
        [Task.async(fn -> load_page(site, i) end) | acc]
      end)

    Enum.map(tasks, &Task.await/1) |> Enum.concat()
  end

  def load_page(site, page_number) do
    [lang, site_name] = String.split(site, "_")
    normalized_lang = String.upcase(lang)
    normalized_site = String.capitalize(site_name)
    loader_name = String.to_existing_atom("Elixir.Randnews.#{normalized_lang}.Loader#{normalized_site}")
    parser_name = String.to_existing_atom("Elixir.Randnews.Parser#{normalized_site}")

    Randnews.Loader.get(loader_name, page_number)
    |> Randnews.Parser.extract_news_headers(parser_name)
  end
end
