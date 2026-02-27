const aws = @import("aws");

/// Configuration information when authentication mode is FEDERATED.
pub const FederationParameters = struct {
    /// The redirect or sign-in URL that should be entered into the SAML 2.0
    /// compliant identity provider configuration
    /// (IdP).
    application_call_back_url: ?[]const u8,

    /// SAML attribute name and value. The name must always be `Email` and the value
    /// should be set to
    /// the attribute definition in which user email is set. For example, name would
    /// be `Email` and
    /// value `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`.
    /// Please check your SAML 2.0 compliant identity provider (IdP) documentation
    /// for details.
    attribute_map: ?[]const aws.map.StringMapEntry,

    /// Name of the identity provider (IdP).
    federation_provider_name: ?[]const u8,

    /// The Uniform Resource Name (URN). Also referred as Service Provider URN or
    /// Audience URI or Service Provider Entity ID.
    federation_urn: ?[]const u8,

    /// SAML 2.0 Metadata document from identity provider (IdP).
    saml_metadata_document: ?[]const u8,

    /// Provide the metadata URL from your SAML 2.0 compliant identity provider
    /// (IdP).
    saml_metadata_url: ?[]const u8,

    pub const json_field_names = .{
        .application_call_back_url = "applicationCallBackURL",
        .attribute_map = "attributeMap",
        .federation_provider_name = "federationProviderName",
        .federation_urn = "federationURN",
        .saml_metadata_document = "samlMetadataDocument",
        .saml_metadata_url = "samlMetadataURL",
    };
};
