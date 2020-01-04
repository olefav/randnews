defmodule Randnews.Loader5 do
  @behaviour Randnews.Loader

  @impl Randnews.Loader
  def base_url do
    "https://www.5.ua/novyny"
  end

  @impl Randnews.Loader
  def page_path_modifier(0) do
    ""
  end

  @impl Randnews.Loader
  def page_path_modifier(page_num) do
    "?page=#{page_num}"
  end
end
