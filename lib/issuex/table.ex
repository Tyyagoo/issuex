defmodule Issuex.Table do
  def render(issues, metadata \\ %{}) do
    title =
      case metadata do
        %{user: user, project: project} -> "Github Issues: [@#{user}/#{project}]"
        _ -> "Github Issues"
      end

    header = ["#", "Created at", "Title"]

    rows =
      issues
      |> Enum.map(fn %{"number" => number, "created_at" => created_at, "title" => title} ->
        [number, created_at, title]
      end)

    TableRex.Table.new()
    |> TableRex.Table.put_column_meta(0, align: :right)
    |> TableRex.Table.put_title(title)
    |> TableRex.Table.put_header(header)
    |> TableRex.Table.add_rows(rows)
    |> TableRex.Table.render!(header_separator_symbol: "=", horizontal_style: :all)
    |> IO.puts()
  end
end
