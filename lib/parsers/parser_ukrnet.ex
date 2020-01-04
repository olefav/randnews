defmodule Randnews.ParserUkrnet do
  @behaviour Randnews.Parser

  def extract_text_from_header({_el, _attrs, [text]}) do
    text
  end

  def news_headers_css do
    ~s(.im-tl_a)
  end
end
