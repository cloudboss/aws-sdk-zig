const CertificateBasedAuthStatus = @import("certificate_based_auth_status.zig").CertificateBasedAuthStatus;

/// The certificate-based authentication properties used to authenticate SAML
/// 2.0 Identity
/// Provider (IdP) user identities to Active Directory domain-joined streaming
/// instances.
/// Fallback is turned on by default when certificate-based authentication is
/// **Enabled** . Fallback allows users to log in using their AD
/// domain password if certificate-based authentication is unsuccessful, or to
/// unlock a
/// desktop lock screen. **Enabled_no_directory_login_fallback** enables
/// certificate-based
/// authentication, but does not allow users to log in using their AD domain
/// password. Users
/// will be disconnected to re-authenticate using certificates.
pub const CertificateBasedAuthProperties = struct {
    /// The ARN of the AWS Certificate Manager Private CA resource.
    certificate_authority_arn: ?[]const u8,

    /// The status of the certificate-based authentication properties.
    status: ?CertificateBasedAuthStatus,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
        .status = "Status",
    };
};
