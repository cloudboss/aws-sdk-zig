/// Describes the Transit Gateway configuration for a Client VPN endpoint.
pub const TransitGatewayConfigurationDescribeEndpointStructure = struct {
    /// The Availability Zone IDs for the Transit Gateway association.
    availability_zone_ids: ?[]const []const u8 = null,

    /// The Availability Zone names for the Transit Gateway association.
    availability_zones: ?[]const []const u8 = null,

    /// The ID of the Transit Gateway attachment.
    transit_gateway_attachment_id: ?[]const u8 = null,

    /// The ID of the Transit Gateway.
    transit_gateway_id: ?[]const u8 = null,
};
