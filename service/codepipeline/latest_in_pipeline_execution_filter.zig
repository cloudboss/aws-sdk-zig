const StartTimeRange = @import("start_time_range.zig").StartTimeRange;

/// The field that specifies to filter on the latest execution in the
/// pipeline.
///
/// Filtering on the latest execution is available for executions run on or
/// after
/// February 08, 2024.
pub const LatestInPipelineExecutionFilter = struct {
    /// The execution ID for the latest execution in the pipeline.
    pipeline_execution_id: []const u8,

    /// The start time to filter on for the latest execution in the pipeline. Valid
    /// options:
    ///
    /// * All
    ///
    /// * Latest
    start_time_range: StartTimeRange,

    pub const json_field_names = .{
        .pipeline_execution_id = "pipelineExecutionId",
        .start_time_range = "startTimeRange",
    };
};
