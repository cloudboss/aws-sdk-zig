/// Contains runtime details for a workflow step that has paused at a
/// `WaitForAction` step, and is waiting for you to send an action.
pub const WorkflowStepExecution = struct {
    /// The name of the step action.
    action: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the image build version that ran the
    /// workflow.
    image_build_version_arn: ?[]const u8 = null,

    /// The name of the workflow step.
    name: ?[]const u8 = null,

    /// The timestamp when the workflow step started.
    start_time: ?[]const u8 = null,

    /// Uniquely identifies the workflow step that ran for the associated
    /// image build version.
    step_execution_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the workflow resource that ran.
    workflow_build_version_arn: ?[]const u8 = null,

    /// Uniquely identifies the runtime instance of the workflow that contains
    /// the workflow step that ran for the associated image build version.
    workflow_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .image_build_version_arn = "imageBuildVersionArn",
        .name = "name",
        .start_time = "startTime",
        .step_execution_id = "stepExecutionId",
        .workflow_build_version_arn = "workflowBuildVersionArn",
        .workflow_execution_id = "workflowExecutionId",
    };
};
