const ContentConfiguration = @import("content_configuration.zig").ContentConfiguration;

/// Configuration for Kinesis Data Stream delivery.
pub const KinesisResource = struct {
    /// Content configurations for stream delivery.
    content_configurations: []const ContentConfiguration,

    /// ARN of the Kinesis Data Stream.
    data_stream_arn: []const u8,

    pub const json_field_names = .{
        .content_configurations = "contentConfigurations",
        .data_stream_arn = "dataStreamArn",
    };
};
