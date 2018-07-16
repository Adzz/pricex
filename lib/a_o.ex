defmodule AO do
  def scrape(uri) do
    uri
    |> URI.to_string()
    |> HTTPoison.get()
    |> case do
      {:ok, res = %{status_code: 200}} -> parse_body(res.body)
      error -> IO.inspect(error, label: "Error!")
    end
  end

  defp parse_body(body) do
    body
    |> Floki.parse()
    |> Floki.find("#hypImage")
    |> Floki.attribute("href")
    |> IO.inspect()
  end
end

# AO.scrape(URI.parse("https://ao.com/l/fridges-built_under/1-9/29-30/"))
