const KinesisStreamConfig = @import("kinesis_stream_config.zig").KinesisStreamConfig;

/// Contains information about the Amazon Kinesis data stream where you're
/// sending real-time log data in a real-time log configuration.
pub const EndPoint = struct {
    /// Contains information about the Amazon Kinesis data stream where you are
    /// sending real-time log data in a real-time log configuration.
    kinesis_stream_config: ?KinesisStreamConfig = null,

    /// The type of data stream where you are sending real-time log data. The only
    /// valid value is `Kinesis`.
    stream_type: []const u8,
};
