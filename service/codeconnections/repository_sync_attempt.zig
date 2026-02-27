const RepositorySyncEvent = @import("repository_sync_event.zig").RepositorySyncEvent;
const RepositorySyncStatus = @import("repository_sync_status.zig").RepositorySyncStatus;

/// Information about a repository sync attempt for a repository with a sync
/// configuration.
pub const RepositorySyncAttempt = struct {
    /// The events associated with a specific sync attempt.
    events: []const RepositorySyncEvent,

    /// The start time of a specific sync attempt.
    started_at: i64,

    /// The status of a specific sync attempt. The following are valid statuses:
    ///
    /// * INITIATED - A repository sync attempt has been created and will begin
    ///   soon.
    ///
    /// * IN_PROGRESS - A repository sync attempt has started and work is being done
    ///   to
    /// reconcile the branch.
    ///
    /// * SUCCEEDED - The repository sync attempt has completed successfully.
    ///
    /// * FAILED - The repository sync attempt has failed.
    ///
    /// * QUEUED - The repository sync attempt didn't execute and was queued.
    status: RepositorySyncStatus,

    pub const json_field_names = .{
        .events = "Events",
        .started_at = "StartedAt",
        .status = "Status",
    };
};
