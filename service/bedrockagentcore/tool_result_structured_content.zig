const TaskStatus = @import("task_status.zig").TaskStatus;

/// Contains structured content from a tool result.
pub const ToolResultStructuredContent = struct {
    /// The execution time of the tool operation in milliseconds.
    execution_time: ?f64,

    /// The exit code from the tool execution.
    exit_code: ?i32,

    /// The standard error output from the tool execution.
    stderr: ?[]const u8,

    /// The standard output from the tool execution.
    stdout: ?[]const u8,

    /// The identifier of the task that produced the result.
    task_id: ?[]const u8,

    /// The status of the task that produced the result.
    task_status: ?TaskStatus,

    pub const json_field_names = .{
        .execution_time = "executionTime",
        .exit_code = "exitCode",
        .stderr = "stderr",
        .stdout = "stdout",
        .task_id = "taskId",
        .task_status = "taskStatus",
    };
};
