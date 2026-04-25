const Channel = @import("channel.zig").Channel;
const IngestConfiguration = @import("ingest_configuration.zig").IngestConfiguration;
const IngestConfigurations = @import("ingest_configurations.zig").IngestConfigurations;
const RecordingConfiguration = @import("recording_configuration.zig").RecordingConfiguration;
const StreamEvent = @import("stream_event.zig").StreamEvent;

/// Object that captures the Amazon IVS configuration that the customer
/// provisioned, the ingest configurations that the broadcaster used, and the
/// most recent Amazon IVS stream events it encountered.
pub const StreamSession = struct {
    /// The properties of the channel at the time of going live.
    channel: ?Channel = null,

    /// Time when the channel went offline. This is an ISO 8601 timestamp; *note
    /// that this is returned as a string*. For live streams, this is `NULL`.
    end_time: ?i64 = null,

    /// The properties of the incoming RTMP stream.
    ///
    /// **Note:** `ingestConfiguration` is deprecated in favor of
    /// `ingestConfigurations` but retained to ensure backward compatibility. If
    /// multitrack is not enabled, `ingestConfiguration` and `ingestConfigurations`
    /// contain the same data, namely information about Track0 (the sole track). If
    /// multitrack is enabled, `ingestConfiguration` contains data for only the
    /// first track (Track0) and `ingestConfigurations` contains data for all
    /// tracks.
    ingest_configuration: ?IngestConfiguration = null,

    /// The properties of the incoming RTMP stream. If multitrack is enabled,
    /// `ingestConfigurations` contains data for all tracks; otherwise, it contains
    /// data only for Track0 (the sole track).
    ingest_configurations: ?IngestConfigurations = null,

    /// The properties of recording the live stream.
    recording_configuration: ?RecordingConfiguration = null,

    /// Time when the channel went live. This is an ISO 8601 timestamp; *note that
    /// this is returned as a string*.
    start_time: ?i64 = null,

    /// Unique identifier for a live or previously live stream in the specified
    /// channel.
    stream_id: ?[]const u8 = null,

    /// List of Amazon IVS events that the stream encountered. The list is sorted by
    /// most recent events and contains up to 500 events. For Amazon IVS events, see
    /// [Using Amazon EventBridge with Amazon
    /// IVS](https://docs.aws.amazon.com/ivs/latest/userguide/eventbridge.html).
    truncated_events: ?[]const StreamEvent = null,

    pub const json_field_names = .{
        .channel = "channel",
        .end_time = "endTime",
        .ingest_configuration = "ingestConfiguration",
        .ingest_configurations = "ingestConfigurations",
        .recording_configuration = "recordingConfiguration",
        .start_time = "startTime",
        .stream_id = "streamId",
        .truncated_events = "truncatedEvents",
    };
};
