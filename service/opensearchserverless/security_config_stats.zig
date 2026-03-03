/// Statistics for an OpenSearch Serverless security configuration.
pub const SecurityConfigStats = struct {
    /// The number of security configurations in the current account.
    saml_config_count: ?i64 = null,

    pub const json_field_names = .{
        .saml_config_count = "SamlConfigCount",
    };
};
