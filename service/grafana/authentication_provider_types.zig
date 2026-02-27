pub const AuthenticationProviderTypes = enum {
    /// Indicates that AMG workspace has AWS SSO enabled as its authentication
    /// provider.
    aws_sso,
    /// Indicates that the AMG workspace has SAML enabled as its authentication
    /// provider.
    saml,

    pub const json_field_names = .{
        .aws_sso = "AWS_SSO",
        .saml = "SAML",
    };
};
