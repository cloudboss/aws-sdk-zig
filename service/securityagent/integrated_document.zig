/// A reference to a document in a third-party provider, such as a Confluence
/// page linked via an integration.
pub const IntegratedDocument = struct {
    /// The identifier of the integration that provides access to the document.
    integration_id: []const u8,

    /// The provider-specific resource identifier for the document.
    resource_id: []const u8,

    pub const json_field_names = .{
        .integration_id = "integrationId",
        .resource_id = "resourceId",
    };
};
