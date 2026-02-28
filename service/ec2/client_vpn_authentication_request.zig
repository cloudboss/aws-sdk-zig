const DirectoryServiceAuthenticationRequest = @import("directory_service_authentication_request.zig").DirectoryServiceAuthenticationRequest;
const FederatedAuthenticationRequest = @import("federated_authentication_request.zig").FederatedAuthenticationRequest;
const CertificateAuthenticationRequest = @import("certificate_authentication_request.zig").CertificateAuthenticationRequest;
const ClientVpnAuthenticationType = @import("client_vpn_authentication_type.zig").ClientVpnAuthenticationType;

/// Describes the authentication method to be used by a Client VPN endpoint. For
/// more information, see
/// [Authentication](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/authentication-authrization.html#client-authentication)
/// in the *Client VPN Administrator Guide*.
pub const ClientVpnAuthenticationRequest = struct {
    /// Information about the Active Directory to be used, if applicable. You must
    /// provide this information if **Type** is `directory-service-authentication`.
    active_directory: ?DirectoryServiceAuthenticationRequest,

    /// Information about the IAM SAML identity provider to be used, if applicable.
    /// You must provide this information if **Type** is `federated-authentication`.
    federated_authentication: ?FederatedAuthenticationRequest,

    /// Information about the authentication certificates to be used, if applicable.
    /// You must provide this information if **Type** is
    /// `certificate-authentication`.
    mutual_authentication: ?CertificateAuthenticationRequest,

    /// The type of client authentication to be used.
    type: ?ClientVpnAuthenticationType,
};
