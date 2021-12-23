defmodule Example.Web.Handler do
  @moduledoc false

  import Aino.Middleware.Routes, only: [routes: 1, get: 3]

  @behaviour Aino.Handler

  routes([
    get("/", &Example.Web.Page.root/1, as: :root)
  ])

  @impl true
  def handle(token) do
    middleware = [
      Aino.Middleware.common(),
      &Aino.Middleware.assets/1,
      &Aino.Middleware.Development.recompile/1,
      &Aino.Middleware.Routes.routes(&1, routes()),
      &Aino.Middleware.Routes.match_route/1,
      &Aino.Middleware.params/1,
      &Aino.Middleware.Routes.handle_route/1,
      &Example.Web.Layout.wrap/1,
      &Aino.Middleware.logging/1
    ]

    Aino.Token.reduce(token, middleware)
  end
end
