defmodule Randnews.JsonLoaderClient do
  use Tesla, only: [:get, :post]

  plug Tesla.Middleware.Headers, [{"user-agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:123.0) Gecko/20100101 Firefox/123.0"}]
  plug Tesla.Middleware.DecodeJson
  plug Tesla.Middleware.EncodeJson
  plug Tesla.Middleware.Logger
end
