const SyncResourceType = @import("sync_resource_type.zig").SyncResourceType;
const SyncResourceStatus = @import("sync_resource_status.zig").SyncResourceStatus;

/// The sync resource summary.
pub const SyncResourceSummary = struct {
    /// The external ID.
    external_id: ?[]const u8,

    /// The resource ID.
    resource_id: ?[]const u8,

    /// The resource type.
    resource_type: ?SyncResourceType,

    /// The sync resource summary status.
    status: ?SyncResourceStatus,

    /// The update date and time.
    update_date_time: ?i64,

    pub const json_field_names = .{
        .external_id = "externalId",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
        .status = "status",
        .update_date_time = "updateDateTime",
    };
};
