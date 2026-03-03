const CertificateBasedAuthProperties = @import("certificate_based_auth_properties.zig").CertificateBasedAuthProperties;
const ServiceAccountCredentials = @import("service_account_credentials.zig").ServiceAccountCredentials;

/// Describes the configuration information required to join fleets and image
/// builders to Microsoft Active Directory domains.
pub const DirectoryConfig = struct {
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
    certificate_based_auth_properties: ?CertificateBasedAuthProperties = null,

    /// The time the directory configuration was created.
    created_time: ?i64 = null,

    /// The fully qualified name of the directory (for example, corp.example.com).
    directory_name: []const u8,

    /// The distinguished names of the organizational units for computer accounts.
    organizational_unit_distinguished_names: ?[]const []const u8 = null,

    /// The credentials for the service account used by the fleet or image builder
    /// to connect to the directory.
    service_account_credentials: ?ServiceAccountCredentials = null,

    pub const json_field_names = .{
        .certificate_based_auth_properties = "CertificateBasedAuthProperties",
        .created_time = "CreatedTime",
        .directory_name = "DirectoryName",
        .organizational_unit_distinguished_names = "OrganizationalUnitDistinguishedNames",
        .service_account_credentials = "ServiceAccountCredentials",
    };
};
