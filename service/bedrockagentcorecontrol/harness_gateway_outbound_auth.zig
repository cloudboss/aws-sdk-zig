const OAuthCredentialProvider = @import("o_auth_credential_provider.zig").OAuthCredentialProvider;

/// Authentication method for calling a Gateway.
pub const HarnessGatewayOutboundAuth = union(enum) {
    /// SigV4-sign requests using the agent's execution role.
    aws_iam: ?struct {},
    /// No authentication.
    none: ?struct {},
    /// Use OAuth credentials for outbound authentication to the gateway.
    ///
    /// The `AUTHORIZATION_CODE` grant type is not supported for outbound
    /// authentication from a harness to an AgentCore Gateway, even when
    /// `defaultReturnUrl` is specified.
    oauth: ?OAuthCredentialProvider,

    pub const json_field_names = .{
        .aws_iam = "awsIam",
        .none = "none",
        .oauth = "oauth",
    };
};
