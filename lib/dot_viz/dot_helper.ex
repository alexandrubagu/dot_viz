defmodule DotViz.Helper do
  @moduledoc false

  def parse_file(filepath) do
    filepath
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&String.match?(&1, ~r/^"[[:alnum:]\/_.]+" -> "[[:alnum:]\/_.]+"$/))
    |> Stream.map(fn line ->
      line
      |> String.replace(~r/ \[label=(.*?)\]/, "")
      |> String.replace("\"", "")
      |> String.split(" -> ")
    end)
  end

  def incoming_edges(stream) do
    Enum.reduce(stream, %{}, fn [from, to], acc -> Map.update(acc, from, [to], &[to | &1]) end)
  end

  def outgoing_edges(stream) do
    Enum.reduce(stream, %{}, fn [from, to], acc -> Map.update(acc, to, [from], &[from | &1]) end)
  end
end
