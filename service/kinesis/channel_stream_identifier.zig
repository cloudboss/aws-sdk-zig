/// Identifies a source stream associated with a channel.
pub const ChannelStreamIdentifier = struct {
    /// The Amazon Resource Name (ARN) of the source Kinesis data stream.
    stream_arn: []const u8,

    /// The time at which the source stream was created.
    stream_creation_timestamp: i64,

    pub const json_field_names = .{
        .stream_arn = "StreamARN",
        .stream_creation_timestamp = "StreamCreationTimestamp",
    };
};
