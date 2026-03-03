const LatestInPipelineExecutionFilter = @import("latest_in_pipeline_execution_filter.zig").LatestInPipelineExecutionFilter;

/// Filter values for the action execution.
pub const ActionExecutionFilter = struct {
    /// The latest execution in the pipeline.
    ///
    /// Filtering on the latest execution is available for executions run on or
    /// after
    /// February 08, 2024.
    latest_in_pipeline_execution: ?LatestInPipelineExecutionFilter = null,

    /// The pipeline execution ID used to filter action execution history.
    pipeline_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .latest_in_pipeline_execution = "latestInPipelineExecution",
        .pipeline_execution_id = "pipelineExecutionId",
    };
};
