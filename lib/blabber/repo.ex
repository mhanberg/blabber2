defmodule Blabber.Repo do
  use Ecto.Repo,
    otp_app: :blabber,
    adapter: Ecto.Adapters.Postgres

  alias Blabber.Config

  def init(_type, config) do
    vapor_config = Vapor.load!(Config)

    config =
      Keyword.merge(config,
        url: vapor_config.database.database_url,
        pool_size: vapor_config.database.pool_size
      )

    {:ok, config}
  end
end
