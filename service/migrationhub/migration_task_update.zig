const Task = @import("task.zig").Task;
const UpdateType = @import("update_type.zig").UpdateType;

/// A migration-task progress update.
pub const MigrationTaskUpdate = struct {
    migration_task_state: ?Task = null,

    /// The timestamp for the update.
    update_date_time: ?i64 = null,

    /// The type of the update.
    update_type: ?UpdateType = null,

    pub const json_field_names = .{
        .migration_task_state = "MigrationTaskState",
        .update_date_time = "UpdateDateTime",
        .update_type = "UpdateType",
    };
};
