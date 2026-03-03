const ArtifactRevision = @import("artifact_revision.zig").ArtifactRevision;
const ExecutionMode = @import("execution_mode.zig").ExecutionMode;
const ExecutionType = @import("execution_type.zig").ExecutionType;
const PipelineRollbackMetadata = @import("pipeline_rollback_metadata.zig").PipelineRollbackMetadata;
const PipelineExecutionStatus = @import("pipeline_execution_status.zig").PipelineExecutionStatus;
const ExecutionTrigger = @import("execution_trigger.zig").ExecutionTrigger;
const ResolvedPipelineVariable = @import("resolved_pipeline_variable.zig").ResolvedPipelineVariable;

/// Represents information about an execution of a pipeline.
pub const PipelineExecution = struct {
    /// A list of `ArtifactRevision` objects included in a pipeline
    /// execution.
    artifact_revisions: ?[]const ArtifactRevision = null,

    /// The method that the pipeline will use to handle multiple executions. The
    /// default
    /// mode is SUPERSEDED.
    execution_mode: ?ExecutionMode = null,

    /// The type of the pipeline execution.
    execution_type: ?ExecutionType = null,

    /// The ID of the pipeline execution.
    pipeline_execution_id: ?[]const u8 = null,

    /// The name of the pipeline with the specified pipeline execution.
    pipeline_name: ?[]const u8 = null,

    /// The version number of the pipeline with the specified pipeline execution.
    pipeline_version: ?i32 = null,

    /// The metadata about the execution pertaining to stage rollback.
    rollback_metadata: ?PipelineRollbackMetadata = null,

    /// The status of the pipeline execution.
    ///
    /// * Cancelled: The pipeline’s definition was updated before the pipeline
    /// execution could be completed.
    ///
    /// * InProgress: The pipeline execution is currently running.
    ///
    /// * Stopped: The pipeline execution was manually stopped. For more
    ///   information,
    /// see [Stopped
    /// Executions](https://docs.aws.amazon.com/codepipeline/latest/userguide/concepts.html#concepts-executions-stopped).
    ///
    /// * Stopping: The pipeline execution received a request to be manually
    ///   stopped.
    /// Depending on the selected stop mode, the execution is either completing or
    /// abandoning in-progress actions. For more information, see [Stopped
    /// Executions](https://docs.aws.amazon.com/codepipeline/latest/userguide/concepts.html#concepts-executions-stopped).
    ///
    /// * Succeeded: The pipeline execution was completed successfully.
    ///
    /// * Superseded: While this pipeline execution was waiting for the next stage
    ///   to
    /// be completed, a newer pipeline execution advanced and continued through the
    /// pipeline instead. For more information, see [Superseded
    /// Executions](https://docs.aws.amazon.com/codepipeline/latest/userguide/concepts.html#concepts-superseded).
    ///
    /// * Failed: The pipeline execution was not completed successfully.
    status: ?PipelineExecutionStatus = null,

    /// A summary that contains a description of the pipeline execution status.
    status_summary: ?[]const u8 = null,

    trigger: ?ExecutionTrigger = null,

    /// A list of pipeline variables used for the pipeline execution.
    variables: ?[]const ResolvedPipelineVariable = null,

    pub const json_field_names = .{
        .artifact_revisions = "artifactRevisions",
        .execution_mode = "executionMode",
        .execution_type = "executionType",
        .pipeline_execution_id = "pipelineExecutionId",
        .pipeline_name = "pipelineName",
        .pipeline_version = "pipelineVersion",
        .rollback_metadata = "rollbackMetadata",
        .status = "status",
        .status_summary = "statusSummary",
        .trigger = "trigger",
        .variables = "variables",
    };
};
