/// The metadata about the Amazon Inspector application data metrics collected
/// by the
/// agent. This data type is used as the response element in the
/// GetTelemetryMetadata action.
pub const TelemetryMetadata = struct {
    /// The count of messages that the agent sends to the Amazon Inspector service.
    count: i64,

    /// The data size of messages that the agent sends to the Amazon Inspector
    /// service.
    data_size: ?i64,

    /// A specific type of behavioral data that is collected by the agent.
    message_type: []const u8,

    pub const json_field_names = .{
        .count = "count",
        .data_size = "dataSize",
        .message_type = "messageType",
    };
};
