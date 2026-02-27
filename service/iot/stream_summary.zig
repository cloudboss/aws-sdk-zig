/// A summary of a stream.
pub const StreamSummary = struct {
    /// A description of the stream.
    description: ?[]const u8,

    /// The stream ARN.
    stream_arn: ?[]const u8,

    /// The stream ID.
    stream_id: ?[]const u8,

    /// The stream version.
    stream_version: ?i32,

    pub const json_field_names = .{
        .description = "description",
        .stream_arn = "streamArn",
        .stream_id = "streamId",
        .stream_version = "streamVersion",
    };
};
