defmodule Quotes.TimelineTest do
  use Quotes.DataCase

  alias Quotes.Timeline

  describe "quotes" do
    alias Quotes.Timeline.Quote

    @valid_attrs %{likes: 42, reposts: 42, text: "some text", username: "some username"}
    @update_attrs %{likes: 43, reposts: 43, text: "some updated text", username: "some updated username"}
    @invalid_attrs %{likes: nil, reposts: nil, text: nil, username: nil}

    def quote_fixture(attrs \\ %{}) do
      {:ok, quote} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timeline.create_quote()

      quote
    end

    test "list_quotes/0 returns all quotes" do
      quote = quote_fixture()
      assert Timeline.list_quotes() == [quote]
    end

    test "get_quote!/1 returns the quote with given id" do
      quote = quote_fixture()
      assert Timeline.get_quote!(quote.id) == quote
    end

    test "create_quote/1 with valid data creates a quote" do
      assert {:ok, %Quote{} = quote} = Timeline.create_quote(@valid_attrs)
      assert quote.likes == 42
      assert quote.reposts == 42
      assert quote.text == "some text"
      assert quote.username == "some username"
    end

    test "create_quote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_quote(@invalid_attrs)
    end

    test "update_quote/2 with valid data updates the quote" do
      quote = quote_fixture()
      assert {:ok, %Quote{} = quote} = Timeline.update_quote(quote, @update_attrs)
      assert quote.likes == 43
      assert quote.reposts == 43
      assert quote.text == "some updated text"
      assert quote.username == "some updated username"
    end

    test "update_quote/2 with invalid data returns error changeset" do
      quote = quote_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_quote(quote, @invalid_attrs)
      assert quote == Timeline.get_quote!(quote.id)
    end

    test "delete_quote/1 deletes the quote" do
      quote = quote_fixture()
      assert {:ok, %Quote{}} = Timeline.delete_quote(quote)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_quote!(quote.id) end
    end

    test "change_quote/1 returns a quote changeset" do
      quote = quote_fixture()
      assert %Ecto.Changeset{} = Timeline.change_quote(quote)
    end
  end
end
