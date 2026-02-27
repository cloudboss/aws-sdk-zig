/// Configuration details for IAM Identity Center Trusted Token Issuer (TTI)
/// authentication.
pub const DataAccessorIdcTrustedTokenIssuerConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the IAM Identity Center Trusted Token
    /// Issuer that will be used for authentication.
    idc_trusted_token_issuer_arn: []const u8,

    pub const json_field_names = .{
        .idc_trusted_token_issuer_arn = "idcTrustedTokenIssuerArn",
    };
};
