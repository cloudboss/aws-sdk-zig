/// Contains information about a text document to rerank.
pub const RerankTextDocument = struct {
    /// The text of the document.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
