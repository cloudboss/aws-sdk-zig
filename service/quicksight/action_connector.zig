const ReadAuthConfig = @import("read_auth_config.zig").ReadAuthConfig;
const ActionConnectorError = @import("action_connector_error.zig").ActionConnectorError;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const ActionConnectorType = @import("action_connector_type.zig").ActionConnectorType;

/// Contains detailed information about an action connector, including its
/// configuration, status, and enabled actions.
pub const ActionConnector = struct {
    /// The unique identifier of the action connector.
    action_connector_id: []const u8,

    /// The Amazon Resource Name (ARN) of the action connector.
    arn: []const u8,

    /// The authentication configuration used to connect to the external service.
    authentication_config: ?ReadAuthConfig,

    /// The timestamp when the action connector was created.
    created_time: ?i64,

    /// The description of the action connector.
    description: ?[]const u8,

    /// The list of actions that are enabled for this connector.
    enabled_actions: ?[]const []const u8,

    /// Error information if the action connector is in an error state.
    @"error": ?ActionConnectorError,

    /// The date and time when the action connector was last updated.
    last_updated_time: i64,

    /// The name of the action connector.
    name: []const u8,

    /// The current status of the action connector.
    status: ?ResourceStatus,

    /// The type of action connector.
    @"type": ActionConnectorType,

    /// The ARN of the VPC connection used for secure connectivity to the external
    /// service.
    vpc_connection_arn: ?[]const u8,

    pub const json_field_names = .{
        .action_connector_id = "ActionConnectorId",
        .arn = "Arn",
        .authentication_config = "AuthenticationConfig",
        .created_time = "CreatedTime",
        .description = "Description",
        .enabled_actions = "EnabledActions",
        .@"error" = "Error",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .status = "Status",
        .@"type" = "Type",
        .vpc_connection_arn = "VpcConnectionArn",
    };
};
