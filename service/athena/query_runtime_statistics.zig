const QueryStage = @import("query_stage.zig").QueryStage;
const QueryRuntimeStatisticsRows = @import("query_runtime_statistics_rows.zig").QueryRuntimeStatisticsRows;
const QueryRuntimeStatisticsTimeline = @import("query_runtime_statistics_timeline.zig").QueryRuntimeStatisticsTimeline;

/// The query execution timeline, statistics on input and output rows and bytes,
/// and the
/// different query stages that form the query execution plan.
pub const QueryRuntimeStatistics = struct {
    /// Stage statistics such as input and output rows and bytes, execution time,
    /// and stage
    /// state. This information also includes substages and the query stage plan.
    output_stage: ?QueryStage,

    rows: ?QueryRuntimeStatisticsRows,

    timeline: ?QueryRuntimeStatisticsTimeline,

    pub const json_field_names = .{
        .output_stage = "OutputStage",
        .rows = "Rows",
        .timeline = "Timeline",
    };
};
