const ActionContext = @import("action_context.zig").ActionContext;
const StageContext = @import("stage_context.zig").StageContext;

/// Represents information about a pipeline to a job worker.
///
/// PipelineContext contains `pipelineArn` and
/// `pipelineExecutionId` for custom action jobs. The
/// `pipelineArn` and `pipelineExecutionId` fields are not
/// populated for ThirdParty action jobs.
pub const PipelineContext = struct {
    /// The context of an action to a job worker in the stage of a pipeline.
    action: ?ActionContext = null,

    /// The Amazon Resource Name (ARN) of the pipeline.
    pipeline_arn: ?[]const u8 = null,

    /// The execution ID of the pipeline.
    pipeline_execution_id: ?[]const u8 = null,

    /// The name of the pipeline. This is a user-specified value. Pipeline names
    /// must be
    /// unique across all pipeline names under an Amazon Web Services account.
    pipeline_name: ?[]const u8 = null,

    /// The stage of the pipeline.
    stage: ?StageContext = null,

    pub const json_field_names = .{
        .action = "action",
        .pipeline_arn = "pipelineArn",
        .pipeline_execution_id = "pipelineExecutionId",
        .pipeline_name = "pipelineName",
        .stage = "stage",
    };
};
