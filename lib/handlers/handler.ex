defmodule Randnews.Handler do
  def load(site, count) do
    [lang, site_name] = String.split(site, "_")
    normalized_lang = String.upcase(lang)
    normalized_site = String.capitalize(site_name)
    loader_name = String.to_existing_atom("Elixir.Randnews.#{normalized_lang}.#{normalized_site}")

    Randnews.Loader.load(loader_name, count)
  end
end
