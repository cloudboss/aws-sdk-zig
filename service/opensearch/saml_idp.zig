/// The SAML identity povider information.
pub const SAMLIdp = struct {
    /// The unique entity ID of the application in the SAML identity provider.
    entity_id: []const u8,

    /// The metadata of the SAML application, in XML format.
    metadata_content: []const u8,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .metadata_content = "MetadataContent",
    };
};
