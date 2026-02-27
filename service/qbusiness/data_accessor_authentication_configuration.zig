const DataAccessorIdcTrustedTokenIssuerConfiguration = @import("data_accessor_idc_trusted_token_issuer_configuration.zig").DataAccessorIdcTrustedTokenIssuerConfiguration;

/// A union type that contains the specific authentication configuration based
/// on the authentication type selected.
pub const DataAccessorAuthenticationConfiguration = union(enum) {
    /// Configuration for IAM Identity Center Trusted Token Issuer (TTI)
    /// authentication used when the authentication type is `AWS_IAM_IDC_TTI`.
    idc_trusted_token_issuer_configuration: ?DataAccessorIdcTrustedTokenIssuerConfiguration,

    pub const json_field_names = .{
        .idc_trusted_token_issuer_configuration = "idcTrustedTokenIssuerConfiguration",
    };
};
