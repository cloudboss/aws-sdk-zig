const RepositorySyncEvent = @import("repository_sync_event.zig").RepositorySyncEvent;
const RepositorySyncStatus = @import("repository_sync_status.zig").RepositorySyncStatus;

/// Detail data for a repository sync attempt activated by a push to a
/// repository.
pub const RepositorySyncAttempt = struct {
    /// Detail data for sync attempt events.
    events: []const RepositorySyncEvent,

    /// The time when the sync attempt started.
    started_at: i64,

    /// The sync attempt status.
    status: RepositorySyncStatus,

    pub const json_field_names = .{
        .events = "events",
        .started_at = "startedAt",
        .status = "status",
    };
};
