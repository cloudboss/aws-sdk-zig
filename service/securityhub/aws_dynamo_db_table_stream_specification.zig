/// The current DynamoDB Streams configuration for the table.
pub const AwsDynamoDbTableStreamSpecification = struct {
    /// Indicates whether DynamoDB Streams is enabled on the table.
    stream_enabled: ?bool = null,

    /// Determines the information that is written to the table.
    stream_view_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .stream_enabled = "StreamEnabled",
        .stream_view_type = "StreamViewType",
    };
};
