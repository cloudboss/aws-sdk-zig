const StreamHealth = @import("stream_health.zig").StreamHealth;
const StreamState = @import("stream_state.zig").StreamState;

/// Specifies a live video stream that has been ingested and distributed.
pub const Stream = struct {
    /// Channel ARN for the stream.
    channel_arn: ?[]const u8 = null,

    /// The stream’s health.
    health: ?StreamHealth = null,

    /// URL of the master playlist, required by the video player to play the HLS
    /// stream.
    playback_url: ?[]const u8 = null,

    /// Time of the stream’s start. This is an ISO 8601 timestamp; *note that this
    /// is returned as a string*.
    start_time: ?i64 = null,

    /// The stream’s state. Do not rely on the `OFFLINE` state, as the API may not
    /// return it; instead, a "NotBroadcasting" error will indicate that the stream
    /// is not live.
    state: ?StreamState = null,

    /// Unique identifier for a live or previously live stream in the specified
    /// channel.
    stream_id: ?[]const u8 = null,

    /// A count of concurrent views of the stream. Typically, a new view appears in
    /// `viewerCount` within 15 seconds of when video playback starts and a view is
    /// removed from `viewerCount` within 1 minute of when video playback ends. A
    /// value of -1 indicates that the request timed out; in this case, retry.
    viewer_count: i64 = 0,

    pub const json_field_names = .{
        .channel_arn = "channelArn",
        .health = "health",
        .playback_url = "playbackUrl",
        .start_time = "startTime",
        .state = "state",
        .stream_id = "streamId",
        .viewer_count = "viewerCount",
    };
};
