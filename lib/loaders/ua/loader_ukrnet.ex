defmodule Randnews.UA.LoaderUkrnet do
  @behaviour Randnews.Loader

  @impl Randnews.Loader
  def base_url do
    "https://www.ukr.net/news/main.html"
  end

  @impl Randnews.Loader
  def page_path_modifier(_) do
    ""
  end
end
