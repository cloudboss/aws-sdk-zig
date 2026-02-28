const StageExecutionStatus = @import("stage_execution_status.zig").StageExecutionStatus;
const ExecutionType = @import("execution_type.zig").ExecutionType;

/// Represents information about the run of a stage.
pub const StageExecution = struct {
    /// The ID of the pipeline execution associated with the stage.
    pipeline_execution_id: []const u8,

    /// The status of the stage, or for a completed stage, the last status of the
    /// stage.
    ///
    /// A status of cancelled means that the pipeline’s definition was updated
    /// before the
    /// stage execution could be completed.
    status: StageExecutionStatus,

    /// The type of pipeline execution for the stage, such as a rollback pipeline
    /// execution.
    @"type": ?ExecutionType,

    pub const json_field_names = .{
        .pipeline_execution_id = "pipelineExecutionId",
        .status = "status",
        .@"type" = "type",
    };
};
