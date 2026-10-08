/// Capabilities for an integrated Confluence space.
pub const ConfluenceResourceCapabilities = struct {
    /// Whether to create documents in this space.
    create_document: ?bool = null,

    /// Whether to fetch documents from this space.
    fetch_document: ?bool = null,

    /// Whether to update documents in this space.
    update_document: ?bool = null,

    pub const json_field_names = .{
        .create_document = "createDocument",
        .fetch_document = "fetchDocument",
        .update_document = "updateDocument",
    };
};
