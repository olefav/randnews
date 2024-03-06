defmodule Randnews.SiteModule do
  @moduledoc """
  A behaviour module with interface for individual news sites to be parsed.

  Any news source needs to implement the 3 functions here:
  - get/1 receives "part_params" which is any data structure representing the "news part" to be downloaded (page number, start/end_date period, ID of some pagination entity etc.)
  and returns the result in a format suitable for further analysis and data extraction (may be for example Floki parsed document structure, JSON response, raw HTML or whatever else)
  - extract_news_headers/1 is passed the data returned by get/1 and is expected to return a list of strings with the relevant news headers
  - set_next_part_params/3 is passed with the "part_params" of the current step, "part_data" which is again the output of get/1 and the "extracted_news_headers" representing the data from extract_news_headers/1. This function is expected to return the state for the next iteration of the getter. Return ":stop" to halt the crawl process, if there's no way of getting more results from the source.

  "part_params" is usually either ":initial" for the first request to the site or "{:next, any()}" for the subsequent ones, but it's not limited to this format for greater flexibility.
  """

  @callback get(part_params :: any()) :: any()
  @callback extract_news_headers(part_data :: any()) :: list()
  @callback set_next_part_params(
              current_part_params :: any(),
              part_data :: any(),
              extracted_news_headers :: list()
            ) :: any()
end
