defmodule Mix.Tasks.Randnews do
  use Mix.Task

  @shortdoc "Main task for interacting with Randnews"
  def run(argv) do
    parsed_arguments =
      OptionParser.parse(argv,
        aliases: [n: :count, f: :file, h: :help],
        strict: [
          count: :integer,
          help: :boolean,
          file: :string,
          only: :string,
          skip: :string
        ]
      )

    process_arguments(parsed_arguments)
  end

  defp process_arguments({parsed, args, invalid}) do
    cond do
      invalid != [] ->
        show_help_message(:global)

      args == ["g"] || args == ["generate"] ->
        generate(parsed)

      args == ["d"] || args == ["dump"] ->
        dump(parsed)

      Keyword.has_key?(parsed, :help) ->
        show_help_message(:global)

      true ->
        show_help_message(:global)
    end
  end

  defp generate(args) do
    if Keyword.has_key?(args, :help) do
      show_help_message(:generate)
    else
      arguments =
        Keyword.merge(
          [
            file: "news.txt",
            count: 20
          ],
          args
        )

      Randnews.generate(arguments[:file], arguments[:count])
      |> Enum.each(fn i -> IO.puts(i) end)
    end
  end

  defp dump(args) do
    Application.ensure_all_started(:hackney)
    Application.ensure_all_started(:iconv)

    if Keyword.has_key?(args, :help) do
      show_help_message(:dump)
    else
      arguments =
        Keyword.merge(
          [
            file: "news.txt",
            count: 50
          ],
          args
        )

      sites = Randnews.Util.SiteSelector.invoke(args)

      Randnews.dump(arguments[:file], arguments[:count], sites)
    end
  end

  defp show_help_message(:global) do
    IO.puts(~s"""
    Usage: mix randnews (generate|dump) [options]
    Global option:
      -h, --help: Show help message.
    Options for individual commands are listed in their help sections:
      mix randnews generate -h and mix randnews dump -h
    """)
  end

  defp show_help_message(:generate) do
    IO.puts(~s"""
    Usage: mix randnews generate [options]
    Avaliable options:
      -f, --file: Path to file with original news headers. Default: news.txt in current directory.
      -n, --count: Number of sentences to generate. Default: 20
    """)
  end

  defp show_help_message(:dump) do
    IO.puts(~s"""
    Usage: mix randnews dump [options]
    Avaliable options:
      -f, --file: Path to file where original news headers will be saved. Default: news.txt in current directory.
      -n, --count: Number of news pages to download. Default: 5
    """)
  end
end
