defmodule Randnews.LoaderTest do
  use ExUnit.Case

  import Tesla.Mock

  setup do
    mock(fn
      %{method: :get, url: "http://example.com/pages/1"} ->
        %Tesla.Env{
          status: 200,
          headers: [{"content-type", "text/html; charset=utf-8"}],
          body: "page 1"
        }

      %{method: :get, url: "http://example.com/pages/2"} ->
        %Tesla.Env{
          status: 200,
          headers: [{"content-type", "text/html; charset=utf-8"}],
          body: "page 2"
        }

      %{method: :get, url: "http://example.com/pages/3"} ->
        %Tesla.Env{
          status: 200,
          headers: [{"content-type", "text/html; charset=windows-1251"}],
          body: :iconv.convert("utf-8", "windows-1251", "page 3")
        }
    end)

    :ok
  end

  defmodule LoaderImpl do
    @behaviour Randnews.Loader

    @impl Randnews.Loader
    def base_url do
      "http://example.com/pages/"
    end

    @impl Randnews.Loader
    def page_path_modifier(0) do
      "1"
    end

    @impl Randnews.Loader
    def page_path_modifier(page_num) do
      "#{page_num + 1}"
    end
  end

  describe "get/1" do
    test "loads the first page" do
      assert Randnews.Loader.get(LoaderImpl) == "page 1"
    end
  end

  describe "get/2" do
    test "loads page by page number" do
      assert Randnews.Loader.get(LoaderImpl, 1) == "page 2"
    end

    test "properly handles win1251 charset" do
      assert Randnews.Loader.get(LoaderImpl, 2) == "page 3"
    end
  end
end
