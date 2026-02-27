const Document = @import("document.zig").Document;

/// Information about the result.
pub const ResultData = struct {
    /// The document.
    document: Document,

    /// The relevance score of the results.
    relevance_score: f64 = 0,

    /// The identifier of the result data.
    result_id: []const u8,

    pub const json_field_names = .{
        .document = "document",
        .relevance_score = "relevanceScore",
        .result_id = "resultId",
    };
};
