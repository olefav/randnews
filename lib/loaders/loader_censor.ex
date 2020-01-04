defmodule Randnews.LoaderCensor do
  @behaviour Randnews.Loader

  @impl Randnews.Loader
  def base_url do
    "https://censor.net.ua/ua/news/all"
  end

  @impl Randnews.Loader
  def page_path_modifier(0) do
    ""
  end

  @impl Randnews.Loader
  def page_path_modifier(page_num) do
    "/page/#{page_num + 1}/category/0/interval/5/sortby/date"
  end
end
