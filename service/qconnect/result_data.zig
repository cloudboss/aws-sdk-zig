const DataSummary = @import("data_summary.zig").DataSummary;
const Document = @import("document.zig").Document;
const QueryResultType = @import("query_result_type.zig").QueryResultType;

/// Information about the result.
pub const ResultData = struct {
    /// Summary of the recommended content.
    data: ?DataSummary = null,

    /// The document.
    document: ?Document = null,

    /// The relevance score of the results.
    relevance_score: f64 = 0,

    /// The identifier of the result data.
    result_id: []const u8,

    /// The type of the query result.
    @"type": ?QueryResultType = null,

    pub const json_field_names = .{
        .data = "data",
        .document = "document",
        .relevance_score = "relevanceScore",
        .result_id = "resultId",
        .@"type" = "type",
    };
};
