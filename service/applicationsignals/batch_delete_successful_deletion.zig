/// Represents a successfully deleted instrumentation configuration.
pub const BatchDeleteSuccessfulDeletion = struct {
    /// Location hash of the deleted configuration (populated only when deleting by
    /// scope).
    location_hash: ?[]const u8 = null,

    /// ARN of the deleted configuration (populated only when deleting by ARN list).
    resource_arn: ?[]const u8 = null,

    /// Signal type of the deleted configuration (populated only when deleting by
    /// scope).
    signal_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .location_hash = "LocationHash",
        .resource_arn = "ResourceArn",
        .signal_type = "SignalType",
    };
};
