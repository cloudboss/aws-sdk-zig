/// Summary information about a cloud connector.
pub const CloudConnectorSummary = struct {
    /// The ID of the cloud connector.
    cloud_connector_id: ?[]const u8 = null,

    /// The date and time the cloud connector was created.
    created_at: ?i64 = null,

    /// The description of the cloud connector.
    description: ?[]const u8 = null,

    /// The friendly name of the cloud connector.
    display_name: ?[]const u8 = null,

    /// The ARN of the IAM role used by the cloud connector.
    role_arn: ?[]const u8 = null,

    /// The date and time the cloud connector was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .cloud_connector_id = "CloudConnectorId",
        .created_at = "CreatedAt",
        .description = "Description",
        .display_name = "DisplayName",
        .role_arn = "RoleArn",
        .updated_at = "UpdatedAt",
    };
};
