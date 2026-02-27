const ApplicationDiscoveryStatus = @import("application_discovery_status.zig").ApplicationDiscoveryStatus;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;
const ApplicationType = @import("application_type.zig").ApplicationType;

/// An SAP application registered with AWS Systems Manager for SAP.
pub const Application = struct {
    /// The Amazon Resource Name (ARN) of the Application Registry.
    app_registry_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the application.
    arn: ?[]const u8,

    /// The Amazon Resource Names of the associated AWS Systems Manager for SAP
    /// applications.
    associated_application_arns: ?[]const []const u8,

    /// The components of the application.
    components: ?[]const []const u8,

    /// The latest discovery result for the application.
    discovery_status: ?ApplicationDiscoveryStatus,

    /// The ID of the application.
    id: ?[]const u8,

    /// The time at which the application was last updated.
    last_updated: ?i64,

    /// The status of the application.
    status: ?ApplicationStatus,

    /// The status message.
    status_message: ?[]const u8,

    /// The type of the application.
    type: ?ApplicationType,

    pub const json_field_names = .{
        .app_registry_arn = "AppRegistryArn",
        .arn = "Arn",
        .associated_application_arns = "AssociatedApplicationArns",
        .components = "Components",
        .discovery_status = "DiscoveryStatus",
        .id = "Id",
        .last_updated = "LastUpdated",
        .status = "Status",
        .status_message = "StatusMessage",
        .type = "Type",
    };
};
