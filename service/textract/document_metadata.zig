/// Information about the input document.
pub const DocumentMetadata = struct {
    /// The number of pages that are detected in the document.
    pages: ?i32,

    pub const json_field_names = .{
        .pages = "Pages",
    };
};
