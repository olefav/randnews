defmodule Randnews.Loader do
  @moduledoc """
  The main Loader module.

  load/2 is its only interface, it accepts a site_module which is required to implement Randnews.SiteModule behaviour, and the expected count of news to be loaded.
  The count argument is the "preferred" number of news headers, but the output might have less data when there is no way of extracting more items out of a news source.
  """

  def load(site_module, count) do
    load_part(site_module, :initial, [], %{news_loaded_count: 0, news_to_load_count: count})
  end

  defp load_part(_site_module, :stop, news_headers, _options) do
    news_headers
  end

  defp load_part(_site_module, _part_info, news_headers, %{
         news_loaded_count: news_loaded_count,
         news_to_load_count: news_to_load_count
       })
       when news_loaded_count >= news_to_load_count do
    news_headers
  end

  defp load_part(site_module, part_params, news_headers, options) do
    part_data = site_module.get(part_params)

    extracted_news_headers = site_module.extract_news_headers(part_data)

    next_part_params =
      site_module.set_next_part_params(part_params, part_data, extracted_news_headers)

    next_options = set_next_options(options, part_data, extracted_news_headers)

    load_part(
      site_module,
      next_part_params,
      news_headers ++ extracted_news_headers,
      next_options
    )
  end

  defp set_next_options(current_options, :stop, _extracted_news_headers) do
    %{current_options | news_to_load_count: 0}
  end

  defp set_next_options(current_options, _part_data, []) do
    %{current_options | news_to_load_count: 0}
  end

  defp set_next_options(current_options, _part_data, extracted_news_headers) do
    already_loaded_news_count = current_options.news_loaded_count

    %{
      current_options
      | news_loaded_count: already_loaded_news_count + length(extracted_news_headers)
    }
  end
end
