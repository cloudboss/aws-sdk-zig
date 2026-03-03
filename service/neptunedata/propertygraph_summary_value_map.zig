const PropertygraphSummary = @import("propertygraph_summary.zig").PropertygraphSummary;

/// Payload for the property graph summary response.
pub const PropertygraphSummaryValueMap = struct {
    /// The graph summary.
    graph_summary: ?PropertygraphSummary = null,

    /// The timestamp, in ISO 8601 format, of the time at which Neptune last
    /// computed statistics.
    last_statistics_computation_time: ?i64 = null,

    /// The version of this graph summary response.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .graph_summary = "graphSummary",
        .last_statistics_computation_time = "lastStatisticsComputationTime",
        .version = "version",
    };
};
