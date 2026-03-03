/// Contains information about the location of a document in a custom data
/// source.
pub const RetrievalResultCustomDocumentLocation = struct {
    /// The ID of the document.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
    };
};
