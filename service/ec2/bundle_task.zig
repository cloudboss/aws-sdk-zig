const BundleTaskError = @import("bundle_task_error.zig").BundleTaskError;
const BundleTaskState = @import("bundle_task_state.zig").BundleTaskState;
const Storage = @import("storage.zig").Storage;

/// Describes a bundle task.
pub const BundleTask = struct {
    /// The ID of the bundle task.
    bundle_id: ?[]const u8,

    /// If the task fails, a description of the error.
    bundle_task_error: ?BundleTaskError,

    /// The ID of the instance associated with this bundle task.
    instance_id: ?[]const u8,

    /// The level of task completion, as a percent (for example, 20%).
    progress: ?[]const u8,

    /// The time this task started.
    start_time: ?i64,

    /// The state of the task.
    state: ?BundleTaskState,

    /// The Amazon S3 storage locations.
    storage: ?Storage,

    /// The time of the most recent update for the task.
    update_time: ?i64,
};
