defmodule Randnews.JsonLoaderClient do
  use Tesla, only: [:get, :post]

  @user_agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:123.0) Gecko/20100101 Firefox/123.0"

  plug(Tesla.Middleware.Headers, [{"user-agent", @user_agent}])

  plug(Tesla.Middleware.DecodeJson)
  plug(Tesla.Middleware.EncodeJson)
  plug(Tesla.Middleware.Logger, log_level: &log_level/1)

  # suppress log messages in test env
  def log_level(_env) do
    case Application.get_env(:randnews, :env) do
      :test -> :debug
      _ -> :default
    end
  end
end
