const Payload = @import("payload.zig").Payload;

/// Sends information about the detector model instance and the event that
/// triggered the
/// action to an Amazon Kinesis Data Firehose delivery stream.
pub const FirehoseAction = struct {
    /// The name of the Kinesis Data Firehose delivery stream where the data is
    /// written.
    delivery_stream_name: []const u8,

    /// You can configure the action payload when you send a message to an Amazon
    /// Kinesis Data Firehose delivery
    /// stream.
    payload: ?Payload,

    /// A character separator that is used to separate records written to the
    /// Kinesis Data
    /// Firehose delivery stream. Valid values are: '\n' (newline), '\t' (tab),
    /// '\r\n' (Windows
    /// newline), ',' (comma).
    separator: ?[]const u8,

    pub const json_field_names = .{
        .delivery_stream_name = "deliveryStreamName",
        .payload = "payload",
        .separator = "separator",
    };
};
