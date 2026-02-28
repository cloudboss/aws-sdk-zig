const AwsEc2ClientVpnEndpointAuthenticationOptionsActiveDirectoryDetails = @import("aws_ec_2_client_vpn_endpoint_authentication_options_active_directory_details.zig").AwsEc2ClientVpnEndpointAuthenticationOptionsActiveDirectoryDetails;
const AwsEc2ClientVpnEndpointAuthenticationOptionsFederatedAuthenticationDetails = @import("aws_ec_2_client_vpn_endpoint_authentication_options_federated_authentication_details.zig").AwsEc2ClientVpnEndpointAuthenticationOptionsFederatedAuthenticationDetails;
const AwsEc2ClientVpnEndpointAuthenticationOptionsMutualAuthenticationDetails = @import("aws_ec_2_client_vpn_endpoint_authentication_options_mutual_authentication_details.zig").AwsEc2ClientVpnEndpointAuthenticationOptionsMutualAuthenticationDetails;

/// Information about the authentication method used by the Client VPN endpoint.
pub const AwsEc2ClientVpnEndpointAuthenticationOptionsDetails = struct {
    /// Information about the Active Directory, if applicable. With Active Directory
    /// authentication, clients are authenticated
    /// against existing Active Directory groups.
    active_directory: ?AwsEc2ClientVpnEndpointAuthenticationOptionsActiveDirectoryDetails,

    /// Information about the IAM SAML identity provider, if applicable.
    federated_authentication: ?AwsEc2ClientVpnEndpointAuthenticationOptionsFederatedAuthenticationDetails,

    /// Information about the authentication certificates, if applicable.
    mutual_authentication: ?AwsEc2ClientVpnEndpointAuthenticationOptionsMutualAuthenticationDetails,

    /// The authentication type used.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .active_directory = "ActiveDirectory",
        .federated_authentication = "FederatedAuthentication",
        .mutual_authentication = "MutualAuthentication",
        .@"type" = "Type",
    };
};
