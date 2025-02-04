defmodule Hermes.StreamProcessor do
  @moduledoc """
  ...

  Module to process a stream from a local video file.
  """

  @output_dir "priv/static/streams"

  @doc """
  ...

  Starts stream from a local video file.

  ## Parameters

  - input_url: String
  - stream_key: String

  ## Examples

  ```elixir
    iex> Hermes.StreamProcessor.start_stream("/path/my_video.mp4", "streamNumber1")
  ```
  """
  def start_stream(input_url, stream_key) do
    output_path = Path.join(@output_dir, stream_key)

    File.mkdir_p!(output_path)

    command = [
      "ffmpeg",
      "-i",
      input_url,
      "-c:v",
      "libx264",
      "-preset",
      "veryfast",
      "-g",
      "50",
      "-hls_time",
      "2",
      "-hls_playlist_type",
      "event",
      "-hls_segment_filename",
      "#{output_path}/%03d.ts",
      "#{output_path}/index.m3u8"
    ]

    Task.start(fn ->
      System.cmd(Enum.at(command, 0), Enum.drop(command, 1))
    end)
  end
end
