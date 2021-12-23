defmodule Example.Web.Layout do
  alias Aino.Token

  require Aino.View

  Aino.View.compile([
    "lib/example/web/templates/layout/app.html.eex"
  ])

  def wrap(token) do
    case Token.response_header(token, "content-type") do
      ["text/html"] ->
        assigns = %{inner_content: token.response_body}
        render(token, "app.html", assigns)

      _ ->
        token
    end
  end
end
