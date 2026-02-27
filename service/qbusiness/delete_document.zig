/// A document deleted from an Amazon Q Business data source connector.
pub const DeleteDocument = struct {
    /// The identifier of the deleted document.
    document_id: []const u8,

    pub const json_field_names = .{
        .document_id = "documentId",
    };
};
