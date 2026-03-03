const ExecutionMode = @import("execution_mode.zig").ExecutionMode;
const ExecutionType = @import("execution_type.zig").ExecutionType;
const PipelineRollbackMetadata = @import("pipeline_rollback_metadata.zig").PipelineRollbackMetadata;
const SourceRevision = @import("source_revision.zig").SourceRevision;
const PipelineExecutionStatus = @import("pipeline_execution_status.zig").PipelineExecutionStatus;
const StopExecutionTrigger = @import("stop_execution_trigger.zig").StopExecutionTrigger;
const ExecutionTrigger = @import("execution_trigger.zig").ExecutionTrigger;

/// Summary information about a pipeline execution.
pub const PipelineExecutionSummary = struct {
    /// The method that the pipeline will use to handle multiple executions. The
    /// default
    /// mode is SUPERSEDED.
    execution_mode: ?ExecutionMode = null,

    /// Type of the pipeline execution.
    execution_type: ?ExecutionType = null,

    /// The date and time of the last change to the pipeline execution, in timestamp
    /// format.
    last_update_time: ?i64 = null,

    /// The ID of the pipeline execution.
    pipeline_execution_id: ?[]const u8 = null,

    /// The metadata for the stage execution to be rolled back.
    rollback_metadata: ?PipelineRollbackMetadata = null,

    /// A list of the source artifact revisions that initiated a pipeline
    /// execution.
    source_revisions: ?[]const SourceRevision = null,

    /// The date and time when the pipeline execution began, in timestamp format.
    start_time: ?i64 = null,

    /// The status of the pipeline execution.
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

    /// Status summary for the pipeline.
    status_summary: ?[]const u8 = null,

    /// The interaction that stopped a pipeline execution.
    stop_trigger: ?StopExecutionTrigger = null,

    /// The interaction or event that started a pipeline execution, such as
    /// automated change
    /// detection or a `StartPipelineExecution` API call.
    trigger: ?ExecutionTrigger = null,

    pub const json_field_names = .{
        .execution_mode = "executionMode",
        .execution_type = "executionType",
        .last_update_time = "lastUpdateTime",
        .pipeline_execution_id = "pipelineExecutionId",
        .rollback_metadata = "rollbackMetadata",
        .source_revisions = "sourceRevisions",
        .start_time = "startTime",
        .status = "status",
        .status_summary = "statusSummary",
        .stop_trigger = "stopTrigger",
        .trigger = "trigger",
    };
};
