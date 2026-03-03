const CertificateBasedAuthStatusEnum = @import("certificate_based_auth_status_enum.zig").CertificateBasedAuthStatusEnum;

/// Describes the properties of the certificate-based authentication you want to
/// use
/// with your WorkSpaces.
pub const CertificateBasedAuthProperties = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Certificate
    /// Manager Private CA resource.
    certificate_authority_arn: ?[]const u8 = null,

    /// The status of the certificate-based authentication properties.
    status: ?CertificateBasedAuthStatusEnum = null,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
        .status = "Status",
    };
};
