const aws = @import("aws");

const TaskParameterValue = @import("task_parameter_value.zig").TaskParameterValue;

/// The specific task, step, and parameters to include.
pub const AssignedTaskRunSessionActionDefinition = struct {
    /// The parameters to include.
    parameters: []const aws.map.MapEntry(TaskParameterValue),

    /// The step ID.
    step_id: []const u8,

    /// The task ID.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .parameters = "parameters",
        .step_id = "stepId",
        .task_id = "taskId",
    };
};
