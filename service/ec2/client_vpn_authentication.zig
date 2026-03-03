const DirectoryServiceAuthentication = @import("directory_service_authentication.zig").DirectoryServiceAuthentication;
const FederatedAuthentication = @import("federated_authentication.zig").FederatedAuthentication;
const CertificateAuthentication = @import("certificate_authentication.zig").CertificateAuthentication;
const ClientVpnAuthenticationType = @import("client_vpn_authentication_type.zig").ClientVpnAuthenticationType;

/// Describes the authentication methods used by a Client VPN endpoint. For more
/// information, see
/// [Authentication](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/client-authentication.html)
/// in the *Client VPN Administrator Guide*.
pub const ClientVpnAuthentication = struct {
    /// Information about the Active Directory, if applicable.
    active_directory: ?DirectoryServiceAuthentication = null,

    /// Information about the IAM SAML identity provider, if applicable.
    federated_authentication: ?FederatedAuthentication = null,

    /// Information about the authentication certificates, if applicable.
    mutual_authentication: ?CertificateAuthentication = null,

    /// The authentication type used.
    @"type": ?ClientVpnAuthenticationType = null,
};
