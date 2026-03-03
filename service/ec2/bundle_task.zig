const BundleTaskError = @import("bundle_task_error.zig").BundleTaskError;
const BundleTaskState = @import("bundle_task_state.zig").BundleTaskState;
const Storage = @import("storage.zig").Storage;

/// Describes a bundle task.
pub const BundleTask = struct {
    /// The ID of the bundle task.
    bundle_id: ?[]const u8 = null,

    /// If the task fails, a description of the error.
    bundle_task_error: ?BundleTaskError = null,

    /// The ID of the instance associated with this bundle task.
    instance_id: ?[]const u8 = null,

    /// The level of task completion, as a percent (for example, 20%).
    progress: ?[]const u8 = null,

    /// The time this task started.
    start_time: ?i64 = null,

    /// The state of the task.
    state: ?BundleTaskState = null,

    /// The Amazon S3 storage locations.
    storage: ?Storage = null,

    /// The time of the most recent update for the task.
    update_time: ?i64 = null,
};
