const RecordConfiguration = @import("record_configuration.zig").RecordConfiguration;

/// Specifies the source stream and record configuration when creating a
/// channel.
pub const ChannelStreamConfiguration = struct {
    /// The record format configuration for the source stream.
    record_configuration: RecordConfiguration,

    /// The Amazon Resource Name (ARN) of the source Kinesis data stream.
    stream_arn: []const u8,

    pub const json_field_names = .{
        .record_configuration = "RecordConfiguration",
        .stream_arn = "StreamARN",
    };
};
