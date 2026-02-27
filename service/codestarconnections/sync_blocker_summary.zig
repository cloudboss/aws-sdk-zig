const SyncBlocker = @import("sync_blocker.zig").SyncBlocker;

/// A summary for sync blockers.
pub const SyncBlockerSummary = struct {
    /// The latest events for a sync blocker summary.
    latest_blockers: ?[]const SyncBlocker,

    /// The parent resource name for a sync blocker summary.
    parent_resource_name: ?[]const u8,

    /// The resource name for sync blocker summary.
    resource_name: []const u8,

    pub const json_field_names = .{
        .latest_blockers = "LatestBlockers",
        .parent_resource_name = "ParentResourceName",
        .resource_name = "ResourceName",
    };
};
