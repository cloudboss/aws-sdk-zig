const StreamChannelDefinition = @import("stream_channel_definition.zig").StreamChannelDefinition;

/// The configuration settings for a stream.
pub const StreamConfiguration = struct {
    /// The unique identifier of the fragment to begin processing.
    fragment_number: ?[]const u8,

    /// The ARN of the stream.
    stream_arn: []const u8,

    /// The streaming channel definition in the stream configuration.
    stream_channel_definition: StreamChannelDefinition,

    pub const json_field_names = .{
        .fragment_number = "FragmentNumber",
        .stream_arn = "StreamArn",
        .stream_channel_definition = "StreamChannelDefinition",
    };
};
