/// Describes SAML options for an OpenSearch Serverless security configuration
/// in the form of a key-value map.
pub const SamlConfigOptions = struct {
    /// The group attribute for this SAML integration.
    group_attribute: ?[]const u8 = null,

    /// The XML IdP metadata file generated from your identity provider.
    metadata: []const u8,

    /// Custom entity ID attribute to override the default entity ID for this SAML
    /// integration.
    open_search_serverless_entity_id: ?[]const u8 = null,

    /// The session timeout, in minutes. Default is 60 minutes (12 hours).
    session_timeout: ?i32 = null,

    /// A user attribute for this SAML integration.
    user_attribute: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_attribute = "groupAttribute",
        .metadata = "metadata",
        .open_search_serverless_entity_id = "openSearchServerlessEntityId",
        .session_timeout = "sessionTimeout",
        .user_attribute = "userAttribute",
    };
};
