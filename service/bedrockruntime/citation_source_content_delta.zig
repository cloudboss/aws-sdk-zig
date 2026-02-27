/// Contains incremental updates to the source content text during streaming
/// responses, allowing clients to build up the cited content progressively.
pub const CitationSourceContentDelta = struct {
    /// An incremental update to the text content from the source document that is
    /// being cited.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
