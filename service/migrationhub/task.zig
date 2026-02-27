const Status = @import("status.zig").Status;

/// Task object encapsulating task information.
pub const Task = struct {
    /// Indication of the percentage completion of the task.
    progress_percent: ?i32,

    /// Status of the task - Not Started, In-Progress, Complete.
    status: Status,

    /// Details of task status as notified by a migration tool. A tool might use
    /// this field to
    /// provide clarifying information about the status that is unique to that tool
    /// or that
    /// explains an error state.
    status_detail: ?[]const u8,

    pub const json_field_names = .{
        .progress_percent = "ProgressPercent",
        .status = "Status",
        .status_detail = "StatusDetail",
    };
};
