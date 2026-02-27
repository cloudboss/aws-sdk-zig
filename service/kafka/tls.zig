/// Details for client authentication using TLS.
pub const Tls = struct {
    /// List of ACM Certificate Authority ARNs.
    certificate_authority_arn_list: ?[]const []const u8,

    /// Specifies whether you want to turn on or turn off TLS authentication.
    enabled: ?bool,

    pub const json_field_names = .{
        .certificate_authority_arn_list = "CertificateAuthorityArnList",
        .enabled = "Enabled",
    };
};
