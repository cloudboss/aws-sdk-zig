const ActionConnectorError = @import("action_connector_error.zig").ActionConnectorError;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const ActionConnectorType = @import("action_connector_type.zig").ActionConnectorType;

/// Contains summary information about an action connector, used in list and
/// search operations.
pub const ActionConnectorSummary = struct {
    /// The unique identifier of the action connector.
    action_connector_id: []const u8,

    /// The Amazon Resource Name (ARN) of the action connector.
    arn: []const u8,

    /// The date and time when the action connector was created.
    created_time: ?i64 = null,

    /// Error information if the action connector is in an error state.
    @"error": ?ActionConnectorError = null,

    /// The date and time when the action connector was last updated.
    last_updated_time: i64,

    /// The name of the action connector.
    name: []const u8,

    /// The current status of the action connector.
    status: ?ResourceStatus = null,

    /// The type of action connector (e.g., SALESFORCE, JIRA, CUSTOM, BEDROCK).
    @"type": ActionConnectorType,

    pub const json_field_names = .{
        .action_connector_id = "ActionConnectorId",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .@"error" = "Error",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .status = "Status",
        .@"type" = "Type",
    };
};
