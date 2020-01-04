defmodule Randnews.Parser112 do
  @behaviour Randnews.Parser

  def extract_text_from_header({_el, _attrs, [text]}) do
    text
  end

  def extract_text_from_header({_el, _attrs, [_, text]}) do
    text
  end

  def news_headers_css do
    ~s(.desc-bold)
  end
end
