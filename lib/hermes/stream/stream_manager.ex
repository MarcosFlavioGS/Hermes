defmodule Hermes.Stream.StreamManager do
  @moduledoc """
  ...
  
  Module responsable for saving index and .ts files.
  """

  @doc """
  ...
  
  Saves the playlist index file into the correct dir name

  ## Parameter

  - body
  - stream_key: String
  """
  def save_index(body, stream_key) do
    path = Path.join(["priv/static/streams", stream_key, "index.m3u8"])

    File.mkdir_p!(Path.dirname(path))
    File.write!(path, body)

    IO.puts("Index.m3u8 saved in /streams/#{stream_key}")
    {:ok, "Index saved"}
  end

  @doc """
  ...

  Saves the .ts file into the correct stream dir

  ## Parameters

  - body
  - stream_key: String
  - file_name: String
  
  """
  def save_ts(body, stream_key, file_name) do
    path = Path.join(["priv/static/streams", stream_key, file_name])

    File.mkdir_p!(Path.dirname(path))
    File.write!(path, body)

    IO.puts("#{file_name} file uploaded to /streams/#{stream_key}")
    {:ok, "TS saved"}
  end
end
