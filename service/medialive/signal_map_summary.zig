const aws = @import("aws");

const SignalMapMonitorDeploymentStatus = @import("signal_map_monitor_deployment_status.zig").SignalMapMonitorDeploymentStatus;
const SignalMapStatus = @import("signal_map_status.zig").SignalMapStatus;

/// Placeholder documentation for SignalMapSummary
pub const SignalMapSummary = struct {
    /// A signal map's ARN (Amazon Resource Name)
    arn: []const u8,

    created_at: i64,

    /// A resource's optional description.
    description: ?[]const u8,

    /// A signal map's id.
    id: []const u8,

    modified_at: ?i64,

    monitor_deployment_status: SignalMapMonitorDeploymentStatus,

    /// A resource's name. Names must be unique within the scope of a resource type
    /// in a specific region.
    name: []const u8,

    status: SignalMapStatus,

    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .id = "Id",
        .modified_at = "ModifiedAt",
        .monitor_deployment_status = "MonitorDeploymentStatus",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
    };
};
