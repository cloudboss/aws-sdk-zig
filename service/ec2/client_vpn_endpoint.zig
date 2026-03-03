const AssociatedTargetNetwork = @import("associated_target_network.zig").AssociatedTargetNetwork;
const ClientVpnAuthentication = @import("client_vpn_authentication.zig").ClientVpnAuthentication;
const ClientConnectResponseOptions = @import("client_connect_response_options.zig").ClientConnectResponseOptions;
const ClientLoginBannerResponseOptions = @import("client_login_banner_response_options.zig").ClientLoginBannerResponseOptions;
const ClientRouteEnforcementResponseOptions = @import("client_route_enforcement_response_options.zig").ClientRouteEnforcementResponseOptions;
const ConnectionLogResponseOptions = @import("connection_log_response_options.zig").ConnectionLogResponseOptions;
const EndpointIpAddressType = @import("endpoint_ip_address_type.zig").EndpointIpAddressType;
const ClientVpnEndpointStatus = @import("client_vpn_endpoint_status.zig").ClientVpnEndpointStatus;
const Tag = @import("tag.zig").Tag;
const TrafficIpAddressType = @import("traffic_ip_address_type.zig").TrafficIpAddressType;
const TransportProtocol = @import("transport_protocol.zig").TransportProtocol;
const VpnProtocol = @import("vpn_protocol.zig").VpnProtocol;

/// Describes a Client VPN endpoint.
pub const ClientVpnEndpoint = struct {
    /// Information about the associated target networks. A target network is a
    /// subnet in a VPC.
    associated_target_networks: ?[]const AssociatedTargetNetwork = null,

    /// Information about the authentication method used by the Client VPN endpoint.
    authentication_options: ?[]const ClientVpnAuthentication = null,

    /// The IPv4 address range, in CIDR notation, from which client IP addresses are
    /// assigned.
    client_cidr_block: ?[]const u8 = null,

    /// The options for managing connection authorization for new client
    /// connections.
    client_connect_options: ?ClientConnectResponseOptions = null,

    /// Options for enabling a customizable text banner that will be displayed on
    /// Amazon Web Services provided clients when a VPN session is
    /// established.
    client_login_banner_options: ?ClientLoginBannerResponseOptions = null,

    /// Client route enforcement is a feature of the Client VPN service that helps
    /// enforce administrator defined routes on devices connected through the VPN. T
    /// his feature helps improve your security posture by ensuring that network
    /// traffic originating from a connected client is not inadvertently sent
    /// outside the VPN tunnel.
    ///
    /// Client route enforcement works by monitoring the route table of a connected
    /// device for routing policy changes to the VPN connection. If the feature
    /// detects any VPN routing policy modifications, it will automatically force an
    /// update to the route table,
    /// reverting it back to the expected route configurations.
    client_route_enforcement_options: ?ClientRouteEnforcementResponseOptions = null,

    /// The ID of the Client VPN endpoint.
    client_vpn_endpoint_id: ?[]const u8 = null,

    /// Information about the client connection logging options for the Client VPN
    /// endpoint.
    connection_log_options: ?ConnectionLogResponseOptions = null,

    /// The date and time the Client VPN endpoint was created.
    creation_time: ?[]const u8 = null,

    /// The date and time the Client VPN endpoint was deleted, if applicable.
    deletion_time: ?[]const u8 = null,

    /// A brief description of the endpoint.
    description: ?[]const u8 = null,

    /// Indicates whether the client VPN session is disconnected after the maximum
    /// `sessionTimeoutHours` is reached. If `true`, users are prompted to reconnect
    /// client VPN. If `false`, client VPN attempts to reconnect automatically. The
    /// default value is `true`.
    disconnect_on_session_timeout: ?bool = null,

    /// The DNS name to be used by clients when connecting to the Client VPN
    /// endpoint.
    dns_name: ?[]const u8 = null,

    /// Information about the DNS servers to be used for DNS resolution.
    dns_servers: ?[]const []const u8 = null,

    /// The IP address type of the Client VPN endpoint. Possible values are `ipv4`
    /// for IPv4 addressing only, `ipv6` for IPv6 addressing only, or `dual-stack
    /// `for both IPv4 and IPv6 addressing.
    endpoint_ip_address_type: ?EndpointIpAddressType = null,

    /// The IDs of the security groups for the target network.
    security_group_ids: ?[]const []const u8 = null,

    /// The URL of the self-service portal.
    self_service_portal_url: ?[]const u8 = null,

    /// The ARN of the server certificate.
    server_certificate_arn: ?[]const u8 = null,

    /// The maximum VPN session duration time in hours.
    ///
    /// Valid values: `8 | 10 | 12 | 24`
    ///
    /// Default value: `24`
    session_timeout_hours: ?i32 = null,

    /// Indicates whether split-tunnel is enabled in the Client VPN endpoint.
    ///
    /// For information about split-tunnel VPN endpoints, see [Split-Tunnel Client
    /// VPN
    /// endpoint](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/split-tunnel-vpn.html)
    /// in the *Client VPN Administrator Guide*.
    split_tunnel: ?bool = null,

    /// The current state of the Client VPN endpoint.
    status: ?ClientVpnEndpointStatus = null,

    /// Any tags assigned to the Client VPN endpoint.
    tags: ?[]const Tag = null,

    /// The IP address type of the Client VPN endpoint. Possible values are either
    /// `ipv4` for IPv4 addressing only, `ipv6` for IPv6 addressing only, or
    /// `dual-stack` for both IPv4 and IPv6 addressing.
    traffic_ip_address_type: ?TrafficIpAddressType = null,

    /// The transport protocol used by the Client VPN endpoint.
    transport_protocol: ?TransportProtocol = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,

    /// The port number for the Client VPN endpoint.
    vpn_port: ?i32 = null,

    /// The protocol used by the VPN session.
    vpn_protocol: ?VpnProtocol = null,
};
