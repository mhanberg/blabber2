defmodule Blabber.Web.Components.TextInput do
  import Temple.Component

  render do
    input type: "text", name: @name, class: assigns[:class]
  end
end
