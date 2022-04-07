defmodule Blabber.Web.Layout do
  alias Aino.Token

  import Blabber

  def wrap(token) do
    case Token.response_header(token, "content-type") do
      ["text/html"] ->
        assigns = %{inner_content: {:safe, token.response_body}}
        render(token, "app.html", assigns)

      _ ->
        token
    end
  end

  render do
    "<!DOCTYPE html>"

    html do
      head do
        title do: "Temple Rulez"
        meta http_equiv: "content-type", content: "text/html;charset=utf-8"
        meta name: "viewport", content: "width=device-width, initial-scale=1.0"

        link href: "/assets/css/app.css", rel: "stylesheet"
      end

      body do
        div class: "mx-16 mt-4" do
          @inner_content
        end
      end
    end
  end
end
