defmodule Quotes.Timeline do
  @moduledoc """
  The Timeline context.
  """

  import Ecto.Query, warn: false
  alias Quotes.Repo

  alias Quotes.Timeline.Quote

  @doc """
  Returns the list of quotes.

  ## Examples

      iex> list_quotes()
      [%Quote{}, ...]

  """
  def list_quotes do
    Repo.all(from q in Quote, order_by: [desc: q.id])
  end

  def increment_likes(%Quote{id: id}) do
      {1, [quote]} = from(q in Quote, where: q.id == ^id, select: q)
      |> Repo.update_all(inc: [likes: 1])

      broadcast({:ok, quote}, :quote_updated)
  end

  def increment_reposts(%Quote{id: id}) do
    {1, [quote]} = from(q in Quote, where: q.id == ^id, select: q)
    |> Repo.update_all(inc: [reposts: 1])

    broadcast({:ok, quote}, :quote_updated)
end

  @doc """
  Gets a single quote.

  Raises `Ecto.NoResultsError` if the Quote does not exist.

  ## Examples

      iex> get_quote!(123)
      %Quote{}

      iex> get_quote!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quote!(id), do: Repo.get!(Quote, id)

  @doc """
  Creates a quote.

  ## Examples

      iex> create_quote(%{field: value})
      {:ok, %Quote{}}

      iex> create_quote(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_quote(attrs \\ %{}) do
    %Quote{}
    |> Quote.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:quote_created)
  end

  @doc """
  Updates a quote.

  ## Examples

      iex> update_quote(quote, %{field: new_value})
      {:ok, %Quote{}}

      iex> update_quote(quote, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_quote(%Quote{} = quote, attrs) do
    quote
    |> Quote.changeset(attrs)
    |> Repo.update()
    |> broadcast(:quote_updated)
  end

  @doc """
  Deletes a quote.

  ## Examples

      iex> delete_quote(quote)
      {:ok, %Quote{}}

      iex> delete_quote(quote)
      {:error, %Ecto.Changeset{}}

  """
  def delete_quote(%Quote{} = quote) do
    Repo.delete(quote)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quote changes.

  ## Examples

      iex> change_quote(quote)
      %Ecto.Changeset{data: %Quote{}}

  """
  def change_quote(%Quote{} = quote, attrs \\ %{}) do
    Quote.changeset(quote, attrs)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Quotes.PubSub, "quotes")
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast({:ok, quote}, event) do
    Phoenix.PubSub.broadcast!(Quotes.PubSub, "quotes", {event, quote})
    {:ok, quote}
  end

end
