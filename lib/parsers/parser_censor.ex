defmodule Randnews.ParserCensor do
  @behaviour Randnews.Parser

  def extract_text_from_header({_el, _attrs, [text]}) do
    text
  end

  def extract_text_from_header({_el, _attrs, [_, text]}) do
    text
  end

  def news_headers_css do
    ~s(article.item.type1 > header > h3 > a)
  end
end
