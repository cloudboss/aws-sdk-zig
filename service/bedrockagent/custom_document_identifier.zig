/// Contains information about the identifier of the document to ingest into a
/// custom data source.
pub const CustomDocumentIdentifier = struct {
    /// The identifier of the document to ingest into a custom data source.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
