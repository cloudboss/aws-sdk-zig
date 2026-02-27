/// Specifies the SAML Identity Provider's information.
pub const SAMLIdp = struct {
    /// The unique Entity ID of the application in SAML Identity Provider.
    entity_id: []const u8,

    /// The Metadata of the SAML application in xml format.
    metadata_content: []const u8,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .metadata_content = "MetadataContent",
    };
};
