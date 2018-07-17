defmodule AO do
  @index_page_images_id "#hypImage"
  @price_selector "span[itemProp=\"price\"]"

  def scrape(uri) do
    uri
    |> URI.to_string()
    |> HTTPoison.get!()
    |> parse_body()
    |> crawl_page()
  end

  defp parse_body(response = %{status_code: 200}) do
    response.body
    |> Floki.parse()
  end

  defp parse_body(error) do
    IO.inspect(error, label: "Error!, response code not 200!")
  end

  defp crawl_page(body) do
    body
    |> Floki.find(@index_page_images_id)
    |> Floki.attribute("href")
    |> Enum.map(fn path ->
      HTTPoison.get!("https://ao.com#{path}") |> parse_body |> extract_information
    end)
  end

  defp extract_information(body) do
    body
    |> Floki.find(".price")
    |> Floki.find("span")
    |> Floki.attribute("content")
    |> IO.inspect()
  end
end

# AO.scrape(URI.parse("https://ao.com/l/fridges-built_under/1-9/29-30/"))
