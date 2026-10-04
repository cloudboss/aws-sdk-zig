/// Filters ListChannels results by source stream.
pub const StreamFilter = struct {
    /// The Amazon Resource Name (ARN) of the source stream to filter by.
    stream_arn: []const u8,

    /// The creation timestamp of the source stream.
    stream_creation_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .stream_arn = "StreamARN",
        .stream_creation_timestamp = "StreamCreationTimestamp",
    };
};
