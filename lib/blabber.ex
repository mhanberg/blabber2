defmodule Blabber do
  defmacro render(do: block) do
    quote do
      def render(var!(token), _, var!(assigns) \\ %{}) do
        require Temple

        var!(assigns) =
          Map.merge(var!(assigns), %{
            scheme: var!(token).scheme,
            host: var!(token).host,
            port: var!(token).port,
            token: var!(token)
          })

        markup =
          Temple.temple do
            unquote(block)
          end

        {:safe, rendered} =
          EEx.eval_string(markup, [assigns: var!(assigns)], engine: Phoenix.HTML.Engine)

        Aino.Token.response_body(var!(token), rendered)
      end
    end
  end
end
