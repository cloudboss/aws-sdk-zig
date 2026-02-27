/// Contains the actual content of a document that can be processed by the model
/// and potentially cited in the response.
pub const DocumentContentBlock = union(enum) {
    /// The text content of the document.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
