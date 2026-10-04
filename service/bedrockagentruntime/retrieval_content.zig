/// The content retrieved from a knowledge source.
pub const RetrievalContent = struct {
    /// The binary content of the retrieved item.
    byte_content: ?[]const u8 = null,

    /// The MIME type of the retrieved content.
    mime_type: []const u8,

    /// The text content of the retrieved item.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .byte_content = "byteContent",
        .mime_type = "mimeType",
        .text = "text",
    };
};
