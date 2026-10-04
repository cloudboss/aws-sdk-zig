const OAuthCredentialProvider = @import("o_auth_credential_provider.zig").OAuthCredentialProvider;

/// Authentication method for calling a Gateway.
pub const HarnessGatewayOutboundAuth = union(enum) {
    /// SigV4-sign requests using the agent's execution role.
    aws_iam: ?struct {},
    /// No authentication.
    none: ?struct {},
    /// Use OAuth credentials for outbound authentication to the gateway.
    oauth: ?OAuthCredentialProvider,

    pub const json_field_names = .{
        .aws_iam = "awsIam",
        .none = "none",
        .oauth = "oauth",
    };
};
