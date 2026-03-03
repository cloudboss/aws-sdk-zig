const ErrorDetails = @import("error_details.zig").ErrorDetails;
const SyncJobState = @import("sync_job_state.zig").SyncJobState;

/// The SyncJob status.
pub const SyncJobStatus = struct {
    /// The SyncJob error.
    @"error": ?ErrorDetails = null,

    /// The SyncJob status state.
    state: ?SyncJobState = null,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
