const AwsEc2ClientVpnEndpointAuthenticationOptionsDetails = @import("aws_ec_2_client_vpn_endpoint_authentication_options_details.zig").AwsEc2ClientVpnEndpointAuthenticationOptionsDetails;
const AwsEc2ClientVpnEndpointClientConnectOptionsDetails = @import("aws_ec_2_client_vpn_endpoint_client_connect_options_details.zig").AwsEc2ClientVpnEndpointClientConnectOptionsDetails;
const AwsEc2ClientVpnEndpointClientLoginBannerOptionsDetails = @import("aws_ec_2_client_vpn_endpoint_client_login_banner_options_details.zig").AwsEc2ClientVpnEndpointClientLoginBannerOptionsDetails;
const AwsEc2ClientVpnEndpointConnectionLogOptionsDetails = @import("aws_ec_2_client_vpn_endpoint_connection_log_options_details.zig").AwsEc2ClientVpnEndpointConnectionLogOptionsDetails;

/// Describes an Client VPN endpoint. A Client VPN endpoint is the resource that
/// you create and
/// configure to enable and manage client VPN sessions. It's the termination
/// point for all client VPN sessions.
pub const AwsEc2ClientVpnEndpointDetails = struct {
    /// Information about the authentication method used by the Client VPN endpoint.
    authentication_options: ?[]const AwsEc2ClientVpnEndpointAuthenticationOptionsDetails = null,

    /// The IPv4 address range, in CIDR notation, from which client IP addresses are
    /// assigned.
    client_cidr_block: ?[]const u8 = null,

    /// The options for managing connection authorization for new client
    /// connections.
    client_connect_options: ?AwsEc2ClientVpnEndpointClientConnectOptionsDetails = null,

    /// Options for enabling a customizable text banner that will be displayed on
    /// Amazon Web Services provided clients when a
    /// VPN session is established.
    client_login_banner_options: ?AwsEc2ClientVpnEndpointClientLoginBannerOptionsDetails = null,

    /// The ID of the Client VPN endpoint.
    client_vpn_endpoint_id: ?[]const u8 = null,

    /// Information about the client connection logging options for the Client VPN
    /// endpoint.
    connection_log_options: ?AwsEc2ClientVpnEndpointConnectionLogOptionsDetails = null,

    /// A brief description of the endpoint.
    description: ?[]const u8 = null,

    /// Information about the DNS servers to be used for DNS resolution.
    dns_server: ?[]const []const u8 = null,

    /// The IDs of the security groups for the target network.
    security_group_id_set: ?[]const []const u8 = null,

    /// The URL of the self-service portal.
    self_service_portal_url: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the server certificate.
    server_certificate_arn: ?[]const u8 = null,

    /// The maximum VPN session duration time in hours.
    session_timeout_hours: ?i32 = null,

    /// Indicates whether split-tunnel is enabled in the Client VPN endpoint.
    split_tunnel: ?bool = null,

    /// The transport protocol used by the Client VPN endpoint.
    transport_protocol: ?[]const u8 = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,

    /// The port number for the Client VPN endpoint.
    vpn_port: ?i32 = null,

    pub const json_field_names = .{
        .authentication_options = "AuthenticationOptions",
        .client_cidr_block = "ClientCidrBlock",
        .client_connect_options = "ClientConnectOptions",
        .client_login_banner_options = "ClientLoginBannerOptions",
        .client_vpn_endpoint_id = "ClientVpnEndpointId",
        .connection_log_options = "ConnectionLogOptions",
        .description = "Description",
        .dns_server = "DnsServer",
        .security_group_id_set = "SecurityGroupIdSet",
        .self_service_portal_url = "SelfServicePortalUrl",
        .server_certificate_arn = "ServerCertificateArn",
        .session_timeout_hours = "SessionTimeoutHours",
        .split_tunnel = "SplitTunnel",
        .transport_protocol = "TransportProtocol",
        .vpc_id = "VpcId",
        .vpn_port = "VpnPort",
    };
};
