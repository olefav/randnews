defmodule Randnews.ParserTest do
  use ExUnit.Case

  defmodule ParserImpl do
    @behaviour Randnews.Parser

    @impl Randnews.Parser
    def extract_text_from_header({_el, _attrs, [text]}) do
      text
    end

    @impl Randnews.Parser
    def news_headers_css do
      ".text"
    end
  end

  describe "extract_news_headers/2" do
    test "extracts necessary elements from HTML text" do
      text = ~S"""
      <html>
        <body>
          <div class="text">
            Example text
          </div>

          <div class="text example">
            Example text 2
          </div>

          <div class="example">
            Example text 3
          </div>
        </body>
      </html>
      """

      assert Randnews.Parser.extract_news_headers(text, ParserImpl) == [
               "Example text",
               "Example text 2"
             ]
    end
  end
end
