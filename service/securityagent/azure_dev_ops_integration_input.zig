/// Connection details for an Azure DevOps integration.
pub const AzureDevOpsIntegrationInput = struct {
    /// The OAuth 2.0 authorization code returned to your redirect URL after the
    /// connection is authorized.
    code: []const u8,

    /// The name of the Azure DevOps organization to connect, for example `my-org`.
    organization_name: []const u8,

    /// The CSRF state value returned by `InitiateProviderRegistration` and echoed
    /// back on the authorization redirect.
    state: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .organization_name = "organizationName",
        .state = "state",
    };
};
