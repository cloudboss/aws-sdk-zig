const StreamStatus = @import("stream_status.zig").StreamStatus;

/// Summary information about a stream.
pub const StreamSummary = struct {
    /// The ARN of the stream.
    arn: []const u8,

    /// The ID of the cluster.
    cluster_identifier: []const u8,

    /// The timestamp when the stream was created.
    creation_time: i64,

    /// The current status of the stream.
    status: StreamStatus,

    /// The ID of the stream.
    stream_identifier: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .cluster_identifier = "clusterIdentifier",
        .creation_time = "creationTime",
        .status = "status",
        .stream_identifier = "streamIdentifier",
    };
};
