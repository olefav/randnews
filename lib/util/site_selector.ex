defmodule Randnews.Util.SiteSelector do
  @sites Application.compile_env(:randnews, :sources)

  def invoke(only: only_sites) do
    site_list =
      only_sites
      |> arg_str_to_list()

    @sites
    |> Enum.filter(fn site ->
      site_list
      |> Enum.member?(site)
    end)
  end

  def invoke(skip: sites_to_skip) do
    site_list =
      sites_to_skip
      |> arg_str_to_list()

    @sites
    |> Enum.reject(fn site ->
      site_list
      |> Enum.member?(site)
    end)
  end

  def invoke(_) do
    @sites
  end

  defp arg_str_to_list(arg_str) do
    arg_str
    |> String.split(",")
  end
end
