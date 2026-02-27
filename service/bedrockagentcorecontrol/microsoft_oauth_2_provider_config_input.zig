/// Input configuration for a Microsoft OAuth2 provider.
pub const MicrosoftOauth2ProviderConfigInput = struct {
    /// The client ID for the Microsoft OAuth2 provider.
    client_id: []const u8,

    /// The client secret for the Microsoft OAuth2 provider.
    client_secret: []const u8,

    /// The Microsoft Entra ID (formerly Azure AD) tenant ID for your organization.
    /// This identifies the specific tenant within Microsoft's identity platform
    /// where your application is registered.
    tenant_id: ?[]const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .tenant_id = "tenantId",
    };
};
