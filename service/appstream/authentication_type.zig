pub const AuthenticationType = enum {
    api,
    saml,
    userpool,
    aws_ad,

    pub const json_field_names = .{
        .api = "API",
        .saml = "SAML",
        .userpool = "USERPOOL",
        .aws_ad = "AWS_AD",
    };
};
