/// Provides details for client authentication using TLS.
pub const AwsMskClusterClusterInfoClientAuthenticationTlsDetails = struct {
    /// List of Amazon Web Services Private CA Amazon Resource Names (ARNs). Amazon
    /// Web Services Private CA enables creation of
    /// private certificate authority (CA) hierarchies, including root and
    /// subordinate CAs, without the investment and maintenance costs
    /// of operating an on-premises CA.
    certificate_authority_arn_list: ?[]const []const u8 = null,

    /// Indicates whether TLS authentication is enabled or not.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .certificate_authority_arn_list = "CertificateAuthorityArnList",
        .enabled = "Enabled",
    };
};
