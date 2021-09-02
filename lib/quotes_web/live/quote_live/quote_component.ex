defmodule QuotesWeb.QuoteLive.QuoteComponent do

  use QuotesWeb, :live_component

  def render(assigns) do
    ~L"""
    <tr id="quote-<%= @quote.id %>">
        <td><%= @quote.username %></td>
        <td><%= @quote.text %></td>
        <td style="text-align:center;"><%= @quote.likes %> <button phx-click="like" phx-target="<%= @myself %>">Like</button></td>
        <td style="text-align:center;"><%= @quote.reposts %> <button phx-click="repost" phx-target="<%= @myself %>">Repost</button></td>

        <td>
          <span><%= live_redirect "Show", to: Routes.quote_show_path(@socket, :show, @quote) %></span>
          <span><%= live_patch "Edit", to: Routes.quote_index_path(@socket, :edit, @quote) %></span>
          <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @quote.id, data: [confirm: "Are you sure?"] %></span>
        </td>
      </tr>
    """
  end

  def handle_event("like",  _, socket) do
    Quotes.Timeline.increment_likes(socket.assigns.quote)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Quotes.Timeline.increment_reposts(socket.assigns.quote)
    {:noreply, socket}
  end

end
