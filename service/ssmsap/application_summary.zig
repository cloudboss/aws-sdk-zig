const aws = @import("aws");

const ApplicationDiscoveryStatus = @import("application_discovery_status.zig").ApplicationDiscoveryStatus;
const ApplicationType = @import("application_type.zig").ApplicationType;

/// The summary of the SAP application registered with AWS Systems Manager for
/// SAP.
pub const ApplicationSummary = struct {
    /// The Amazon Resource Name (ARN) of the application.
    arn: ?[]const u8,

    /// The status of the latest discovery.
    discovery_status: ?ApplicationDiscoveryStatus,

    /// The ID of the application.
    id: ?[]const u8,

    /// The tags on the application.
    tags: ?[]const aws.map.StringMapEntry,

    /// The type of the application.
    @"type": ?ApplicationType,

    pub const json_field_names = .{
        .arn = "Arn",
        .discovery_status = "DiscoveryStatus",
        .id = "Id",
        .tags = "Tags",
        .@"type" = "Type",
    };
};
