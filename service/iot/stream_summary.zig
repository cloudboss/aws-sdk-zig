/// A summary of a stream.
pub const StreamSummary = struct {
    /// A description of the stream.
    description: ?[]const u8 = null,

    /// The stream ARN.
    stream_arn: ?[]const u8 = null,

    /// The stream ID.
    stream_id: ?[]const u8 = null,

    /// The stream version.
    stream_version: ?i32 = null,

    pub const json_field_names = .{
        .description = "description",
        .stream_arn = "streamArn",
        .stream_id = "streamId",
        .stream_version = "streamVersion",
    };
};
