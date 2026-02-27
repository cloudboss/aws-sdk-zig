const DataSummary = @import("data_summary.zig").DataSummary;

/// Details of streaming chunk data for email generative answers including
/// completion text and references.
pub const EmailGenerativeAnswerChunkDataDetails = struct {
    /// The partial or complete text content of the generative answer response.
    completion: ?[]const u8,

    /// Token for retrieving the next chunk of streaming response data, if
    /// available.
    next_chunk_token: ?[]const u8,

    /// Source references and citations from knowledge base articles used to
    /// generate the answer.
    references: ?[]const DataSummary,

    pub const json_field_names = .{
        .completion = "completion",
        .next_chunk_token = "nextChunkToken",
        .references = "references",
    };
};
