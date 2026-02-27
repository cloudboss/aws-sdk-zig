const LatestInPipelineExecutionFilter = @import("latest_in_pipeline_execution_filter.zig").LatestInPipelineExecutionFilter;

/// Filter values for the rule execution.
pub const RuleExecutionFilter = struct {
    latest_in_pipeline_execution: ?LatestInPipelineExecutionFilter,

    /// The pipeline execution ID used to filter rule execution history.
    pipeline_execution_id: ?[]const u8,

    pub const json_field_names = .{
        .latest_in_pipeline_execution = "latestInPipelineExecution",
        .pipeline_execution_id = "pipelineExecutionId",
    };
};
