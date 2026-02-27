/// This property contains the document to chat with, along with its attributes.
pub const ByteContentDoc = struct {
    /// The MIME type of the document contained in the wrapper object.
    content_type: []const u8,

    /// The byte value of the file to upload, encoded as a Base-64 string.
    data: []const u8,

    /// The file name of the document contained in the wrapper object.
    identifier: []const u8,

    pub const json_field_names = .{
        .content_type = "contentType",
        .data = "data",
        .identifier = "identifier",
    };
};
