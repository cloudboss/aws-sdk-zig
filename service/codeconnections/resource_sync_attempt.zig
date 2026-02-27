const ResourceSyncEvent = @import("resource_sync_event.zig").ResourceSyncEvent;
const Revision = @import("revision.zig").Revision;
const ResourceSyncStatus = @import("resource_sync_status.zig").ResourceSyncStatus;

/// Information about a resource sync attempt.
pub const ResourceSyncAttempt = struct {
    /// The events related to a resource sync attempt.
    events: []const ResourceSyncEvent,

    /// The current state of the resource as defined in the resource's `config-file`
    /// in the linked repository.
    initial_revision: Revision,

    /// The start time for a resource sync attempt.
    started_at: i64,

    /// The status for a resource sync attempt. The follow are valid statuses:
    ///
    /// * SYNC-INITIATED - A resource sync attempt has been created and will begin
    ///   soon.
    ///
    /// * SYNCING - Syncing has started and work is being done to reconcile state.
    ///
    /// * SYNCED - Syncing has completed successfully.
    ///
    /// * SYNC_FAILED - A resource sync attempt has failed.
    status: ResourceSyncStatus,

    /// The name of the Amazon Web Services resource that is attempted to be
    /// synchronized.
    target: []const u8,

    /// The desired state of the resource as defined in the resource's `config-file`
    /// in the linked repository. Git sync attempts to update the resource to this
    /// state.
    target_revision: Revision,

    pub const json_field_names = .{
        .events = "Events",
        .initial_revision = "InitialRevision",
        .started_at = "StartedAt",
        .status = "Status",
        .target = "Target",
        .target_revision = "TargetRevision",
    };
};
