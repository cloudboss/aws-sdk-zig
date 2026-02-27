const MessagingDataType = @import("messaging_data_type.zig").MessagingDataType;

/// The configuration for connecting a messaging stream to Amazon Kinesis.
pub const StreamingConfiguration = struct {
    /// The data type of the configuration.
    data_type: MessagingDataType,

    /// The ARN of the resource in the configuration.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .data_type = "DataType",
        .resource_arn = "ResourceArn",
    };
};
