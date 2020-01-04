defmodule Randnews.Loader112 do
  @behaviour Randnews.Loader

  @impl Randnews.Loader
  def base_url do
    "https://ua.112.ua/archive/fun"
  end

  @impl Randnews.Loader
  def page_path_modifier(0) do
    ""
  end

  @impl Randnews.Loader
  def page_path_modifier(page_num) do
    "/p#{page_num + 1}"
  end
end
