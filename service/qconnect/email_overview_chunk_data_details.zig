/// Details of streaming chunk data for email overview including completion text
/// and pagination tokens.
pub const EmailOverviewChunkDataDetails = struct {
    /// The partial or complete overview text content in structured HTML format with
    /// customer issues, resolutions, and next steps.
    completion: ?[]const u8 = null,

    /// Token for retrieving the next chunk of streaming overview data, if
    /// available.
    next_chunk_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion = "completion",
        .next_chunk_token = "nextChunkToken",
    };
};
