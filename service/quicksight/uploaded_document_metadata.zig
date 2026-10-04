/// Metadata for an uploaded document associated with a custom instruction.
pub const UploadedDocumentMetadata = struct {
    /// The name of the uploaded document.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
