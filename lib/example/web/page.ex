defmodule Example.Web.Page do
  alias Aino.Token
  alias Example.Web.Page.View

  def root(token) do
    token
    |> Token.response_status(200)
    |> Token.response_header("Content-Type", "text/html")
    |> View.render("root.html")
  end
end

defmodule Example.Web.Page.View do
  require Aino.View

  Aino.View.compile([
    "lib/example/web/templates/pages/root.html.eex"
  ])
end
