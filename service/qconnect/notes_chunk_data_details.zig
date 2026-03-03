/// Details about notes chunk data.
pub const NotesChunkDataDetails = struct {
    /// A chunk of the notes completion.
    completion: ?[]const u8 = null,

    /// The token for the next chunk of notes data.
    next_chunk_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion = "completion",
        .next_chunk_token = "nextChunkToken",
    };
};
