defmodule Blabber.Web.Layout do
  alias Aino.Token

  import Temple

  def wrap(token) do
    case Token.response_header(token, "content-type") do
      ["text/html"] ->
        assigns = %{inner_content: {:safe, token.response_body}}
        Aino.View.render_template(__MODULE__, token, "app.html", assigns)

      _ ->
        token
    end
  end

  def simple_render("app.html", assigns) do
    temple do
      "<!DOCTYPE html>"

      html do
        head do
          title do: "Temple Rulez"
          meta http_equiv: "content-type", content: "text/html;charset=utf-8"
          meta name: "viewport", content: "width=device-width, initial-scale=1.0"

          link rel: "shortcut icon",
               href:
                 "data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20100%20100%22%3E%3Ctext%20y%3D%22.9em%22%20font-size%3D%2290%22%3E%F0%9F%A6%85%3C%2Ftext%3E%3C%2Fsvg%3E",
               type: "image/svg+xml"

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
end
