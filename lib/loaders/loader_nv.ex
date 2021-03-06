defmodule Randnews.LoaderNV do
  @behaviour Randnews.Loader

  @impl Randnews.Loader
  def base_url do
    "https://nv.ua/ukr/allnews.html"
  end

  @impl Randnews.Loader
  def page_path_modifier(0) do
    ""
  end

  @impl Randnews.Loader
  def page_path_modifier(page_num) do
    "?page=#{page_num + 1}"
  end
end
