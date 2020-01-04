defmodule Randnews.LoaderPravda do
  @behaviour Randnews.Loader

  @impl Randnews.Loader
  def base_url do
    "https://www.pravda.com.ua"
  end

  @impl Randnews.Loader
  def page_path_modifier(0) do
    "/news/"
  end

  @impl Randnews.Loader
  def page_path_modifier(page_num) do
    "/auth/dyn-content/page_#{page_num}/"
  end
end
