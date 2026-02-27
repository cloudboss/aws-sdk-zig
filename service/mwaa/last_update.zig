const UpdateError = @import("update_error.zig").UpdateError;
const UpdateStatus = @import("update_status.zig").UpdateStatus;
const WorkerReplacementStrategy = @import("worker_replacement_strategy.zig").WorkerReplacementStrategy;

/// Describes the status of the last update on the environment, and any errors
/// that were encountered.
pub const LastUpdate = struct {
    /// The day and time of the last update on the environment.
    created_at: ?i64,

    /// The error that was encountered during the last update of the environment.
    @"error": ?UpdateError,

    /// The source of the last update to the environment. Includes internal
    /// processes by Amazon MWAA, such as an environment maintenance update.
    source: ?[]const u8,

    /// The status of the last update on the environment.
    status: ?UpdateStatus,

    /// The worker replacement strategy used in the last update of the environment.
    worker_replacement_strategy: ?WorkerReplacementStrategy,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .@"error" = "Error",
        .source = "Source",
        .status = "Status",
        .worker_replacement_strategy = "WorkerReplacementStrategy",
    };
};
