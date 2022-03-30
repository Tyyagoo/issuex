defmodule Issuex.Github.Issues do
  require Logger

  @user_agent {"User-agent", "Elixir tyyagoosantos@gmail.com"}
  @github_url Application.get_env(:issuex, :github_url)

  def fetch(user, project) do
    Logger.info("Fetching issues for [@#{user}/#{project}]")

    issues_url(user, project)
    |> HTTPoison.get([@user_agent])
    |> handle_response()
  end

  @spec issues_url(String.t(), String.t()) :: String.t()
  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  @spec handle_response({:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}) ::
          {:ok | :error, HTTPoison.body()} | {:error, any}
  defp handle_response({:ok, %{status_code: status_code, body: body}}) do
    Logger.info("Got response: status_code=#{status_code}")
    Logger.debug(fn -> inspect(body) end)

    case status_code do
      200 -> {:ok, Jason.decode!(body)}
      _ -> {:error, Jason.decode!(body)}
    end
  end

  defp handle_response({:error, %{reason: reason}}) do
    Logger.error("Didn't get response: reason=#{inspect(reason)}")

    {:error, reason}
  end
end
