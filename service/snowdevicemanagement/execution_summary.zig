const ExecutionState = @import("execution_state.zig").ExecutionState;

/// The summary of a task execution on a specified device.
pub const ExecutionSummary = struct {
    /// The ID of the execution.
    execution_id: ?[]const u8 = null,

    /// The ID of the managed device that the task is being executed on.
    managed_device_id: ?[]const u8 = null,

    /// The state of the execution.
    state: ?ExecutionState = null,

    /// The ID of the task.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .execution_id = "executionId",
        .managed_device_id = "managedDeviceId",
        .state = "state",
        .task_id = "taskId",
    };
};
