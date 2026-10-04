const RecordConfiguration = @import("record_configuration.zig").RecordConfiguration;

/// Describes the source stream of a channel.
pub const ChannelStreamDescription = struct {
    /// The record format configuration for the source stream.
    record_configuration: RecordConfiguration,

    /// The Amazon Resource Name (ARN) of the source Kinesis data stream.
    stream_arn: []const u8,

    /// The time at which the source stream was created.
    stream_creation_timestamp: i64,

    pub const json_field_names = .{
        .record_configuration = "RecordConfiguration",
        .stream_arn = "StreamARN",
        .stream_creation_timestamp = "StreamCreationTimestamp",
    };
};
