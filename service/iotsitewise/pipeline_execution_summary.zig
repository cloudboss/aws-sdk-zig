const PipelineExecutionStatus = @import("pipeline_execution_status.zig").PipelineExecutionStatus;

/// Contains summary information about a pipeline execution.
pub const PipelineExecutionSummary = struct {
    /// The time the pipeline execution completed, in Unix epoch time.
    end_time: ?i64 = null,

    /// Scheduling priority for the execution. When not specified, defaults to
    /// lowest priority.
    execution_priority: ?i32 = null,

    /// The unique identifier of the pipeline execution.
    pipeline_execution_id: []const u8,

    /// The pipeline version this execution ran against.
    pipeline_version: []const u8,

    /// The time the pipeline execution started, in Unix epoch time.
    start_time: ?i64 = null,

    /// The current execution status of the pipeline.
    status: PipelineExecutionStatus,

    pub const json_field_names = .{
        .end_time = "endTime",
        .execution_priority = "executionPriority",
        .pipeline_execution_id = "pipelineExecutionId",
        .pipeline_version = "pipelineVersion",
        .start_time = "startTime",
        .status = "status",
    };
};
