defmodule QuotesWeb.QuoteLive.FormComponent do
  use QuotesWeb, :live_component

  alias Quotes.Timeline

  @impl true
  def update(%{quote: quote} = assigns, socket) do
    changeset = Timeline.change_quote(quote)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"quote" => quote_params}, socket) do
    changeset =
      socket.assigns.quote
      |> Timeline.change_quote(quote_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"quote" => quote_params}, socket) do
    save_quote(socket, socket.assigns.action, quote_params)
  end

  defp save_quote(socket, :edit, quote_params) do
    case Timeline.update_quote(socket.assigns.quote, quote_params) do
      {:ok, _quote} ->
        {:noreply,
         socket
         |> put_flash(:info, "Quote updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_quote(socket, :new, quote_params) do
    case Timeline.create_quote(quote_params) do
      {:ok, _quote} ->
        {:noreply,
         socket
         |> put_flash(:info, "Quote created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
