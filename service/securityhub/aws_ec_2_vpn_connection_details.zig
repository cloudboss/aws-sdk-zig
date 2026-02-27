const AwsEc2VpnConnectionOptionsDetails = @import("aws_ec_2_vpn_connection_options_details.zig").AwsEc2VpnConnectionOptionsDetails;
const AwsEc2VpnConnectionRoutesDetails = @import("aws_ec_2_vpn_connection_routes_details.zig").AwsEc2VpnConnectionRoutesDetails;
const AwsEc2VpnConnectionVgwTelemetryDetails = @import("aws_ec_2_vpn_connection_vgw_telemetry_details.zig").AwsEc2VpnConnectionVgwTelemetryDetails;

/// Details about an Amazon EC2 VPN
/// connection.
pub const AwsEc2VpnConnectionDetails = struct {
    /// The category of the VPN connection. `VPN` indicates an Amazon Web Services
    /// VPN connection. `VPN-Classic`
    /// indicates an Amazon Web Services Classic VPN connection.
    category: ?[]const u8,

    /// The configuration information for the VPN connection's customer gateway, in
    /// the native XML
    /// format.
    customer_gateway_configuration: ?[]const u8,

    /// The identifier of the customer gateway that is at your end of the VPN
    /// connection.
    customer_gateway_id: ?[]const u8,

    /// The VPN connection options.
    options: ?AwsEc2VpnConnectionOptionsDetails,

    /// The static routes that are associated with the VPN connection.
    routes: ?[]const AwsEc2VpnConnectionRoutesDetails,

    /// The current state of the VPN connection. Valid values are as follows:
    ///
    /// * `available`
    ///
    /// * `deleted`
    ///
    /// * `deleting`
    ///
    /// * `pending`
    state: ?[]const u8,

    /// The identifier of the transit gateway that is associated with the VPN
    /// connection.
    transit_gateway_id: ?[]const u8,

    /// The type of VPN connection.
    type: ?[]const u8,

    /// Information about the VPN tunnel.
    vgw_telemetry: ?[]const AwsEc2VpnConnectionVgwTelemetryDetails,

    /// The identifier of the VPN connection.
    vpn_connection_id: ?[]const u8,

    /// The identifier of the virtual private gateway that is at the Amazon Web
    /// Services side of the VPN
    /// connection.
    vpn_gateway_id: ?[]const u8,

    pub const json_field_names = .{
        .category = "Category",
        .customer_gateway_configuration = "CustomerGatewayConfiguration",
        .customer_gateway_id = "CustomerGatewayId",
        .options = "Options",
        .routes = "Routes",
        .state = "State",
        .transit_gateway_id = "TransitGatewayId",
        .type = "Type",
        .vgw_telemetry = "VgwTelemetry",
        .vpn_connection_id = "VpnConnectionId",
        .vpn_gateway_id = "VpnGatewayId",
    };
};
