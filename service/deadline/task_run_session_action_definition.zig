const aws = @import("aws");

const TaskParameterValue = @import("task_parameter_value.zig").TaskParameterValue;

/// The task, step, and parameters for the task run in the session action.
pub const TaskRunSessionActionDefinition = struct {
    /// The task parameters.
    parameters: []const aws.map.MapEntry(TaskParameterValue),

    /// The step ID.
    step_id: []const u8,

    /// The task ID.
    task_id: ?[]const u8,

    pub const json_field_names = .{
        .parameters = "parameters",
        .step_id = "stepId",
        .task_id = "taskId",
    };
};
