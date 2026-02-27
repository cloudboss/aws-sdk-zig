/// Input configuration for a Salesforce OAuth2 provider.
pub const SalesforceOauth2ProviderConfigInput = struct {
    /// The client ID for the Salesforce OAuth2 provider.
    client_id: []const u8,

    /// The client secret for the Salesforce OAuth2 provider.
    client_secret: []const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
    };
};
