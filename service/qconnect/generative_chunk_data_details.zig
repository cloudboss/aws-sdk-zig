const DataSummary = @import("data_summary.zig").DataSummary;

/// Details about the generative chunk data.
pub const GenerativeChunkDataDetails = struct {
    /// A chunk of the LLM response.
    completion: ?[]const u8,

    /// The token for the next set of chunks. Use the value returned in the previous
    /// response in the next request to retrieve the next set of chunks.
    next_chunk_token: ?[]const u8,

    /// The references used to generate the LLM response.
    references: ?[]const DataSummary,

    pub const json_field_names = .{
        .completion = "completion",
        .next_chunk_token = "nextChunkToken",
        .references = "references",
    };
};
