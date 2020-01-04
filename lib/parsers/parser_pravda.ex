defmodule Randnews.ParserPravda do
  @behaviour Randnews.Parser

  def extract_text_from_header({"a", _attrs, [text]}) do
    text
  end

  def extract_text_from_header({"a", _attrs, [{"em", _}, text]}) do
    text
  end

  def extract_text_from_header({"a", _attrs, [{"em", _, _}, text]}) do
    text
  end

  def extract_text_from_header({"a", _attrs, [text, _]}) do
    text
  end

  def news_headers_css do
    ~s(.article__title > a)
  end
end
