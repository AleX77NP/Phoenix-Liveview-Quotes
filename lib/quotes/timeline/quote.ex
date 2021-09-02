defmodule Quotes.Timeline.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    field :likes, :integer, default: 0
    field :reposts, :integer, default: 0
    field :text, :string
    field :username, :string, default: "alexandar12"

    timestamps()
  end

  @doc false
  def changeset(quote, attrs) do
    quote
    |> cast(attrs, [:text])
    |> validate_required([:text])
    |> validate_length(:text, min: 2, max: 250)
  end
end
