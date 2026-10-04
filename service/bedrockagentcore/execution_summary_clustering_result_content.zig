const ExecutionSummaryCluster = @import("execution_summary_cluster.zig").ExecutionSummaryCluster;

/// The execution summary clustering result containing grouped execution
/// patterns identified across evaluated sessions.
pub const ExecutionSummaryClusteringResultContent = struct {
    /// The list of execution summary clusters identified across analyzed sessions.
    execution_summaries: []const ExecutionSummaryCluster,

    pub const json_field_names = .{
        .execution_summaries = "executionSummaries",
    };
};
