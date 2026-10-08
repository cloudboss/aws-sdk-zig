/// Details specific to a registered Azure identity using AWS Outbound Identity
/// Federation.
pub const RegisteredAzureIdentityDetails = struct {
    /// The client ID of the service principal or managed identity used for
    /// authentication.
    client_id: []const u8,

    /// The Azure Active Directory tenant ID for the identity.
    tenant_id: []const u8,

    /// The role ARN to be assumed by DevOps Agent for requesting Web Identity
    /// Token.
    web_identity_role_arn: []const u8,

    /// The audiences for the Web Identity Token.
    web_identity_token_audiences: []const []const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .tenant_id = "tenantId",
        .web_identity_role_arn = "webIdentityRoleArn",
        .web_identity_token_audiences = "webIdentityTokenAudiences",
    };
};
