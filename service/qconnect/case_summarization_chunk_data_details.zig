/// Details about case summarization chunk data.
pub const CaseSummarizationChunkDataDetails = struct {
    /// A chunk of the case summarization completion.
    completion: ?[]const u8 = null,

    /// Token for retrieving the next chunk of streaming summarization data, if
    /// available.
    next_chunk_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion = "completion",
        .next_chunk_token = "nextChunkToken",
    };
};
