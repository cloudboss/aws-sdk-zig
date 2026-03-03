const aws = @import("aws");

const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;
const IntegrationType = @import("integration_type.zig").IntegrationType;

/// A summary of information about a code security integration.
pub const CodeSecurityIntegrationSummary = struct {
    /// The timestamp when the code security integration was created.
    created_on: i64,

    /// The Amazon Resource Name (ARN) of the code security integration.
    integration_arn: []const u8,

    /// The timestamp when the code security integration was last updated.
    last_update_on: i64,

    /// The name of the code security integration.
    name: []const u8,

    /// The current status of the code security integration.
    status: IntegrationStatus,

    /// The reason for the current status of the code security integration.
    status_reason: []const u8,

    /// The tags associated with the code security integration.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of repository provider for the integration.
    @"type": IntegrationType,

    pub const json_field_names = .{
        .created_on = "createdOn",
        .integration_arn = "integrationArn",
        .last_update_on = "lastUpdateOn",
        .name = "name",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
        .@"type" = "type",
    };
};
