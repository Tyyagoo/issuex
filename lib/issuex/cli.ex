defmodule Issuex.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the oldest _n_ issues in a github project
  """

  @default_count 4

  def run(args) do
    args
    |> parse()
    |> process()
  end

  def parse(args) do
    args
    |> OptionParser.parse(switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> parse_args()
  end

  def process(:help) do
    IO.puts("""
    usage: issues <user> <project> [ count | #{@default_count} ]
    """)

    System.halt(0)
  end

  def process({user, project, count}) do
    Issuex.Github.Issues.fetch(user, project)
    |> handle_github_response()
    |> Enum.sort_by(&Map.get(&1, "number"))
    |> Enum.take(count)
    |> Issuex.Table.render(%{user: user, project: project})
  end

  defp parse_args([user, project, count]), do: {user, project, String.to_integer(count)}
  defp parse_args([user, project]), do: {user, project, @default_count}
  defp parse_args(_), do: :help

  defp handle_github_response({:ok, body}), do: body

  defp handle_github_response({:error, err}) do
    IO.inspect(err, label: "Error fetching from Github")
    System.halt(2)
  end
end
