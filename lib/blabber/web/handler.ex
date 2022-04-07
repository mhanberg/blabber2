defmodule Blabber.Web.Handler do
  @moduledoc false

  import Aino.Middleware.Routes, only: [routes: 1, get: 3, post: 3, delete: 3]

  @behaviour Aino.Handler

  routes([
    get("/", &Blabber.Web.Page.root/1, as: :root),
    post("/thoughts", &Blabber.Web.Thoughts.create/1, as: :create),
    delete("/thoughts/:id", &Blabber.Web.Thoughts.delete/1, as: :delete),
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
      &Blabber.Web.Layout.wrap/1,
      &Aino.Middleware.logging/1
    ]

    Aino.Token.reduce(token, middleware)
  end
end
