/// The resource properties associated with the integration target.
pub const TargetProcessingProperties = struct {
    /// The Glue network connection to configure the Glue job running in the
    /// customer VPC.
    connection_name: ?[]const u8 = null,

    /// The ARN of an Eventbridge event bus to receive the integration status
    /// notification.
    event_bus_arn: ?[]const u8 = null,

    /// The ARN of the KMS key used for encryption.
    kms_arn: ?[]const u8 = null,

    /// The IAM role to access the Glue database.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .event_bus_arn = "EventBusArn",
        .kms_arn = "KmsArn",
        .role_arn = "RoleArn",
    };
};
