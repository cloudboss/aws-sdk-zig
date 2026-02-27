const ResourceSyncEvent = @import("resource_sync_event.zig").ResourceSyncEvent;
const Revision = @import("revision.zig").Revision;
const ResourceSyncStatus = @import("resource_sync_status.zig").ResourceSyncStatus;

/// Detail data for a resource sync attempt activated by a push to a repository.
pub const ResourceSyncAttempt = struct {
    /// An array of events with detail data.
    events: []const ResourceSyncEvent,

    /// Detail data for the initial repository commit, path and push.
    initial_revision: Revision,

    /// The time when the sync attempt started.
    started_at: i64,

    /// The status of the sync attempt.
    status: ResourceSyncStatus,

    /// The resource that is synced to.
    target: []const u8,

    /// Detail data for the target revision.
    target_revision: Revision,

    pub const json_field_names = .{
        .events = "events",
        .initial_revision = "initialRevision",
        .started_at = "startedAt",
        .status = "status",
        .target = "target",
        .target_revision = "targetRevision",
    };
};
