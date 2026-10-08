/// Destination for publishing scan reports to an integrated document provider.
pub const ReportDestination = struct {
    /// The container identifier where the report will be published.
    container_id: []const u8,

    /// The existing document identifier to update instead of creating a new
    /// document.
    document_id: ?[]const u8 = null,

    /// The integration identifier for the document provider.
    integration_id: []const u8,

    /// The parent document identifier under which the report will be created.
    parent_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_id = "containerId",
        .document_id = "documentId",
        .integration_id = "integrationId",
        .parent_id = "parentId",
    };
};
