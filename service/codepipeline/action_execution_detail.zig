const ActionExecutionInput = @import("action_execution_input.zig").ActionExecutionInput;
const ActionExecutionOutput = @import("action_execution_output.zig").ActionExecutionOutput;
const ActionExecutionStatus = @import("action_execution_status.zig").ActionExecutionStatus;

/// Returns information about an execution of an action, including the action
/// execution
/// ID, and the name, version, and timing of the action.
pub const ActionExecutionDetail = struct {
    /// The action execution ID.
    action_execution_id: ?[]const u8 = null,

    /// The name of the action.
    action_name: ?[]const u8 = null,

    /// Input details for the action execution, such as role ARN, Region, and input
    /// artifacts.
    input: ?ActionExecutionInput = null,

    /// The last update time of the action execution.
    last_update_time: ?i64 = null,

    /// Output details for the action execution, such as the action execution
    /// result.
    output: ?ActionExecutionOutput = null,

    /// The pipeline execution ID for the action execution.
    pipeline_execution_id: ?[]const u8 = null,

    /// The version of the pipeline where the action was run.
    pipeline_version: ?i32 = null,

    /// The name of the stage that contains the action.
    stage_name: ?[]const u8 = null,

    /// The start time of the action execution.
    start_time: ?i64 = null,

    /// The status of the action execution. Status categories are `InProgress`,
    /// `Succeeded`, and `Failed`.
    status: ?ActionExecutionStatus = null,

    /// The ARN of the user who changed the pipeline execution details.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_execution_id = "actionExecutionId",
        .action_name = "actionName",
        .input = "input",
        .last_update_time = "lastUpdateTime",
        .output = "output",
        .pipeline_execution_id = "pipelineExecutionId",
        .pipeline_version = "pipelineVersion",
        .stage_name = "stageName",
        .start_time = "startTime",
        .status = "status",
        .updated_by = "updatedBy",
    };
};
