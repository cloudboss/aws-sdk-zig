const GatewayAssociationState = @import("gateway_association_state.zig").GatewayAssociationState;
const VpnConnectionOptions = @import("vpn_connection_options.zig").VpnConnectionOptions;
const VpnStaticRoute = @import("vpn_static_route.zig").VpnStaticRoute;
const VpnState = @import("vpn_state.zig").VpnState;
const Tag = @import("tag.zig").Tag;
const GatewayType = @import("gateway_type.zig").GatewayType;
const VgwTelemetry = @import("vgw_telemetry.zig").VgwTelemetry;

/// Describes a VPN connection.
pub const VpnConnection = struct {
    /// The category of the VPN connection. A value of `VPN` indicates an Amazon Web
    /// Services VPN connection. A value of `VPN-Classic` indicates an Amazon Web
    /// Services Classic VPN connection.
    category: ?[]const u8,

    /// The ARN of the core network.
    core_network_arn: ?[]const u8,

    /// The ARN of the core network attachment.
    core_network_attachment_arn: ?[]const u8,

    /// The configuration information for the VPN connection's customer gateway (in
    /// the native
    /// XML format). This element is always present in the CreateVpnConnection
    /// response; however, it's present in the DescribeVpnConnections response
    /// only if the VPN connection is in the `pending` or `available`
    /// state.
    customer_gateway_configuration: ?[]const u8,

    /// The ID of the customer gateway at your end of the VPN connection.
    customer_gateway_id: ?[]const u8,

    /// The current state of the gateway association.
    gateway_association_state: ?GatewayAssociationState,

    /// The VPN connection options.
    options: ?VpnConnectionOptions,

    /// The Amazon Resource Name (ARN) of the Secrets Manager secret storing the
    /// pre-shared key(s) for the VPN connection.
    pre_shared_key_arn: ?[]const u8,

    /// The static routes associated with the VPN connection.
    routes: ?[]const VpnStaticRoute,

    /// The current state of the VPN connection.
    state: ?VpnState,

    /// Any tags assigned to the VPN connection.
    tags: ?[]const Tag,

    /// The ID of the transit gateway associated with the VPN connection.
    transit_gateway_id: ?[]const u8,

    /// The type of VPN connection.
    type: ?GatewayType,

    /// Information about the VPN tunnel.
    vgw_telemetry: ?[]const VgwTelemetry,

    /// The ID of the VPN concentrator associated with the VPN connection.
    vpn_concentrator_id: ?[]const u8,

    /// The ID of the VPN connection.
    vpn_connection_id: ?[]const u8,

    /// The ID of the virtual private gateway at the Amazon Web Services side of the
    /// VPN
    /// connection.
    vpn_gateway_id: ?[]const u8,
};
