const RDFGraphSummary = @import("rdf_graph_summary.zig").RDFGraphSummary;

/// Payload for an RDF graph summary response.
pub const RDFGraphSummaryValueMap = struct {
    /// The graph summary of an RDF graph. See [Graph summary response for an RDF
    /// graph](https://docs.aws.amazon.com/neptune/latest/userguide/neptune-graph-summary.html#neptune-graph-summary-rdf-response).
    graph_summary: ?RDFGraphSummary = null,

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
