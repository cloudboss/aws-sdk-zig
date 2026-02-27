const RuleExecutionInput = @import("rule_execution_input.zig").RuleExecutionInput;
const RuleExecutionOutput = @import("rule_execution_output.zig").RuleExecutionOutput;
const RuleExecutionStatus = @import("rule_execution_status.zig").RuleExecutionStatus;

/// The details of the runs for a rule and the results produced on an artifact
/// as it
/// passes through stages in the pipeline.
pub const RuleExecutionDetail = struct {
    /// Input details for the rule execution, such as role ARN, Region, and input
    /// artifacts.
    input: ?RuleExecutionInput,

    /// The date and time of the last change to the rule execution, in timestamp
    /// format.
    last_update_time: ?i64,

    /// Output details for the rule execution, such as the rule execution result.
    output: ?RuleExecutionOutput,

    /// The ID of the pipeline execution in the stage where the rule was run. Use
    /// the GetPipelineState action to retrieve the current pipelineExecutionId of
    /// the stage.
    pipeline_execution_id: ?[]const u8,

    /// The version number of the pipeline with the stage where the rule was run.
    pipeline_version: ?i32,

    /// The ID of the run for the rule.
    rule_execution_id: ?[]const u8,

    /// The name of the rule that was run in the stage.
    rule_name: ?[]const u8,

    /// The name of the stage where the rule was run.
    stage_name: ?[]const u8,

    /// The start time of the rule execution.
    start_time: ?i64,

    /// The status of the rule execution. Status categories are `InProgress`,
    /// `Succeeded`, and `Failed`.
    status: ?RuleExecutionStatus,

    /// The ARN of the user who changed the rule execution details.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .input = "input",
        .last_update_time = "lastUpdateTime",
        .output = "output",
        .pipeline_execution_id = "pipelineExecutionId",
        .pipeline_version = "pipelineVersion",
        .rule_execution_id = "ruleExecutionId",
        .rule_name = "ruleName",
        .stage_name = "stageName",
        .start_time = "startTime",
        .status = "status",
        .updated_by = "updatedBy",
    };
};
