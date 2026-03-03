const aws = @import("aws");

const TaskParameterValue = @import("task_parameter_value.zig").TaskParameterValue;

/// The details of a task run in a session action.
pub const TaskRunSessionActionDefinitionSummary = struct {
    /// The parameters of a task run in a session action.
    parameters: ?[]const aws.map.MapEntry(TaskParameterValue) = null,

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
