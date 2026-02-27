/// Details of streaming chunk data for email responses including completion
/// text and pagination tokens.
pub const EmailResponseChunkDataDetails = struct {
    /// The partial or complete professional email response text with appropriate
    /// greetings and closings.
    completion: ?[]const u8,

    /// Token for retrieving the next chunk of streaming response data, if
    /// available.
    next_chunk_token: ?[]const u8,

    pub const json_field_names = .{
        .completion = "completion",
        .next_chunk_token = "nextChunkToken",
    };
};
