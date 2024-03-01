defmodule Randnews.SiteModule do
  @callback get(part_params :: map()) :: {:ok, any()} | {:error, any()}
  @callback extract_news_headers(data :: any()) :: list()
  @callback set_next_part_params(
              current_part_params :: any(),
              part_data :: any(),
              extracted_news_headers :: list()
            ) :: any()
end
