const StreamModeDetails = @import("stream_mode_details.zig").StreamModeDetails;
const StreamStatus = @import("stream_status.zig").StreamStatus;

/// The summary of a stream.
pub const StreamSummary = struct {
    /// The ARN of the stream.
    stream_arn: []const u8,

    /// The timestamp at which the stream was created.
    stream_creation_timestamp: ?i64,

    stream_mode_details: ?StreamModeDetails,

    /// The name of a stream.
    stream_name: []const u8,

    /// The status of the stream.
    stream_status: StreamStatus,

    pub const json_field_names = .{
        .stream_arn = "StreamARN",
        .stream_creation_timestamp = "StreamCreationTimestamp",
        .stream_mode_details = "StreamModeDetails",
        .stream_name = "StreamName",
        .stream_status = "StreamStatus",
    };
};
