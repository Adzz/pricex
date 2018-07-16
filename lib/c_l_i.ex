defmodule CLI do
  def main(_) do
    IO.gets("""
    Hello, please paste in the URL of the website you want to scrape,
    then press enter:
    """)
    |> URI.parse()
    |> process
  end

  def process(uri = %URI{host: "ao.com"}) do
    AO.scrape(uri)
  end
end
