const SyncResourceType = @import("sync_resource_type.zig").SyncResourceType;
const SyncResourceState = @import("sync_resource_state.zig").SyncResourceState;

/// The sync resource filter.
pub const SyncResourceFilter = union(enum) {
    /// The external ID.
    external_id: ?[]const u8,
    /// The sync resource filter resource ID.
    resource_id: ?[]const u8,
    /// The sync resource filter resource type
    resource_type: ?SyncResourceType,
    /// The sync resource filter's state.
    state: ?SyncResourceState,

    pub const json_field_names = .{
        .external_id = "externalId",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
        .state = "state",
    };
};
