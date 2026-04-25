const NetworkMigrationFailedResourceStatus = @import("network_migration_failed_resource_status.zig").NetworkMigrationFailedResourceStatus;

/// Details about a resource that failed to deploy.
pub const NetworkMigrationFailedResourceDetails = struct {
    /// The logical ID of the failed resource.
    logical_id: ?[]const u8 = null,

    /// The status of the failed resource.
    status: ?NetworkMigrationFailedResourceStatus = null,

    /// The reason why the resource failed.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .logical_id = "logicalID",
        .status = "status",
        .status_reason = "statusReason",
    };
};
